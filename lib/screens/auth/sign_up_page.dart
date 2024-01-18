import 'package:flutter/material.dart';
import 'package:ivrapp/constants.dart';
import 'package:ivrapp/screens/auth/custom_divider.dart';
import 'package:ivrapp/screens/auth/custom_row.dart';
import 'package:ivrapp/screens/auth/services/auth_services.dart';
import 'package:ivrapp/screens/auth/sign_in_page.dart';
import 'package:ivrapp/screens/home/home_screen.dart';
import 'package:ivrapp/widgets/custom_textfield.dart';
import 'package:ivrapp/widgets/showSnackBar.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int index = 0;
  String res = 'not good';
  final _signupkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _namecontroller.dispose();
    _passwordcontroller.dispose();
  }

  void createUser() async {
    res = await AuthServices().signUpUser(
        username: _namecontroller.text.trim(),
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim());
    showSnackBar(context, res);
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
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: Row(
                  children: [
                    Text(
                      "Let\'s Begin with\nIllness-free Journey",
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
                          key: _signupkey,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  keyboardType: TextInputType.name,
                                  hintText: 'Enter your name',
                                  controller: _namecontroller,
                                ),
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
                                        if (_signupkey.currentState!
                                            .validate()) {
                                          if (_passwordcontroller.text
                                                  .trim()
                                                  .length >=
                                              6) {
                                            createUser();
                                          } else {
                                            showSnackBar(context,
                                                'Password must be of more than 6 characters');
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                CustomDivider(),
                                CustomRow(
                                    buttonContent: "Sign in",
                                    function: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInScreen()));
                                    },
                                    supportingText: "Have an Account?")
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
