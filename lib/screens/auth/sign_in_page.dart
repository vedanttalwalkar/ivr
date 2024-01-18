import 'package:flutter/material.dart';
import 'package:ivrapp/constants.dart';
import 'package:ivrapp/screens/auth/custom_divider.dart';
import 'package:ivrapp/screens/auth/custom_row.dart';
import 'package:ivrapp/screens/auth/services/auth_services.dart';
import 'package:ivrapp/screens/home/home_screen.dart';
import 'package:ivrapp/widgets/custom_textfield.dart';
import 'package:ivrapp/widgets/showSnackBar.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  int index = 0;
  String res = 'not good';
  final _signinkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    res = await AuthServices().loginUser(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim());

    if (res == 'Login Successful') {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 30),
                child: Row(
                  children: [
                    Text(
                      "Let\'s Get\nStarted",
                      style: const TextStyle(fontSize: 36, color: whiteColor),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                          key: _signinkey,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'Enter your email',
                                  controller: _emailcontroller,
                                ),
                                CustomTextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  hintText: 'Enter your password',
                                  controller: _passwordcontroller,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, bottom: 20),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              50),
                                          backgroundColor: greenColor),
                                      onPressed: () {
                                        if (_signinkey.currentState!
                                            .validate()) {
                                          loginUser();
                                          print('Login success!');
                                        }
                                      },
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                CustomDivider(),
                                CustomRow(
                                    buttonContent: "Sign up",
                                    function: () {
                                      Navigator.pop(context);
                                    },
                                    supportingText:
                                        "New Here? Let\'s get you going")
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
