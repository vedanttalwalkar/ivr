from langchain.memory import ConversationBufferMemory
from langchain.prompts import PromptTemplate
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_community.llms import CTransformers
from langchain.chains import RetrievalQA,ConversationalRetrievalChain


DB_FAISS_PATH = 'vectorstore2/db_faiss'

custom_prompt_template = """You are a doctor.From the data you have on medicines, give the user the information that you can give in short and don't make up any answers 
provide them correct and honest answers if you don't know tell -  "I am sorry I don't know"


Context: {context}

chat_history = {chat_history}
Question: {question}

Only return the helpful answer below and nothing else.
Helpful answer:
"""

def set_custom_prompt():
    """
    Prompt template for QA retrieval for each vectorstore
    """
    prompt = PromptTemplate(template=custom_prompt_template,
                            input_variables=['chat_history','context', 'question'])
    return prompt

#Retrieval QA Chain
def retrieval_qa_chain(llm, prompt, db):
    memory =  ConversationBufferMemory(memory_key="chat_history", input_key='question', output_key='answer', return_messages=True)
    qa_chain =ConversationalRetrievalChain.from_llm(
    llm=llm,
    memory=memory,
    retriever=db.as_retriever(search_kwargs={'k': 2}),
    return_source_documents=True,
    combine_docs_chain_kwargs={'prompt': prompt}
)

    return qa_chain

#Loading the model
def load_llm():
    # Load the locally downloaded model here
    llm = CTransformers(
        model = "TheBloke/Llama-2-7B-Chat-GGML",
        model_type="llama",
        max_new_tokens = 512,
        temperature = 0.5
    )
    return llm

embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2",
                                       model_kwargs={'device': 'cpu'})
db = FAISS.load_local(DB_FAISS_PATH, embeddings)
llm = load_llm()
#QA Model Function
def qa_bot():
    qa_prompt = set_custom_prompt()
    qa = retrieval_qa_chain(llm, qa_prompt, db)
    return qa

#output function
def final_result(query):
    qa_result = qa_bot()
    response = qa_result({'question': query})
    ans = response['answer']
    
    # for answer in ans:
    #     if answer=='\n':
    #         ans=ans.split(answer)
    return ans


def chatbot(userinput):
    # user_name = input("chatbot::Hello User! Can you provide your name?\n User::")
    # location = input(f"Hello {user_name}! Please provide your location\n User::")
    #print("Ask your query")
    user_input = userinput
    if any(word in user_input.lower() for word in ('bye','thanks','thank','time','thank you','goodbye','adios','see you later','later','farewell')):
        return ("Goodbye! If you have more questions in the future, feel free to ask. Take care!")
        
    else:
        answer=final_result(user_input)
        return answer

        

