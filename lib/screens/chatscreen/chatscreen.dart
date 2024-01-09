import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ivrapp/constants.dart';
import 'package:ivrapp/httprequests/get_chatbot_result.dart';
import 'package:ivrapp/screens/auth/auth_screen.dart';
import 'package:ivrapp/screens/chatscreen/widgets/chattextfield.dart';
import 'package:ivrapp/screens/chatscreen/widgets/messagebox.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatcontroller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  IconData icon = Icons.mic;
  bool fieldEmpty = true;
  String text = '';
  String reply = '';
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chatcontroller.dispose();
  }

  void isFieldEmpty(String text) {
    setState(() {
      if (text.trim().isNotEmpty) {
        fieldEmpty = false;
      } else {
        fieldEmpty = true;
      }
    });
  }

  void getreply() async {
    setState(() {
      userinput.add(MessageBox(text: '...',sender: 'bot'));
    });
    reply=await ChatbotResult().getchatbotreult(context: context, userinput: text);
    setState(() {
      userinput.removeLast();
      userinput.add(MessageBox(
        text: reply,
        sender: 'bot',
      ));
    });
  }

  List<MessageBox> userinput = [
    MessageBox(
      text: 'Hello from bot!!',
      sender: 'bot',
    ),

  ];

  void scrolldown()
  {
    if (_scrollController.hasClients) {
      final position = _scrollController.position.maxScrollExtent;
      _scrollController.jumpTo(position);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){signOut();}, icon: Icon(Icons.logout,color: whiteColor,))
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return userinput[index];
              },
              itemCount: userinput.length,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomChatTextField(
                  onChanged: (newText) {
                    isFieldEmpty(newText);
                  },
                  hintText: 'Ask chatbot',
                  controller: _chatcontroller,
                  keyboardType: TextInputType.text,
                ),
              ),
              IconButton(
                  onPressed: fieldEmpty
                      ? () {
                          print('mic is on');
                        }
                      : () {
                          setState(() {
                            text = _chatcontroller.text.trim();
                            userinput.add(MessageBox(text: text));

                            getreply();
                            scrolldown();
                            _chatcontroller.clear();
                            fieldEmpty = true;
                            popKeyboard(context);
                          });
                        },
                  icon: Icon(
                    fieldEmpty ? Icons.mic : Icons.telegram_rounded,
                    size: 40,
                  ))
            ],
          ),
        ],
      ),
    );
  }
  void signOut()async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName, (route) => false);
  }
}

void popKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}
