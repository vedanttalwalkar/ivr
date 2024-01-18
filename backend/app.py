from flask import Flask,request
from flask_smorest import abort
from new_ocr import extract_medicine_names
from flask_cors import CORS
from model2 import chatbot
import json
app=Flask(__name__)
CORS(app)
@app.post("/get-ocr")
def send_ocr_res():
    req_data=request.get_json()
    try:
        
        url=req_data['url']
        ocr=extract_medicine_names(url)
        print(ocr[0])
        return {"message":ocr}
    except:
        return {"message":"error"}

@app.get("/get-ocr")
def hello():
    return {"message":"hoi"}



@app.post("/chatbot")
def chat_bot():
    req_data=request.get_json()
    userinput=req_data['userinput']
    try:
        result=chatbot(userinput)
        result=result.replace("\n"," ")
        return {"result":result}
    except :
        return{"message":"error occured"}

if __name__ == '__main__':
    from pyngrok import ngrok
    port = 5000
    public_url =  "https://a5a6-49-128-170-166.ngrok-free.app"
    print(public_url+'/get-ocr')
    app.run(port=port)    

