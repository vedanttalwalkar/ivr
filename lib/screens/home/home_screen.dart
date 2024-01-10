import 'package:flutter/material.dart';
import 'package:ivrapp/constants.dart';
import 'package:ivrapp/model/user.dart';
import 'package:ivrapp/pick_file.dart';
import 'package:ivrapp/providers/user_provider.dart';
import 'package:ivrapp/screens/auth/services/auth_services.dart';
import 'package:ivrapp/screens/chatscreen/chatscreen.dart';
import 'package:ivrapp/screens/crop_image/crop_image_screen.dart';
import 'package:ivrapp/widgets/showAlert.dart';
import 'package:ivrapp/widgets/show_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
    AuthServices().getUserDetails(context: context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ModelUser user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      drawer: showDrawer(context: context),
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteColor),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.routeName);
              },
              icon: Icon(
                Icons.message_rounded,
                color: whiteColor,
              ))
        ],
      ),
      body: Container(
        child: Center(
          child: Text(user.email),
        ),
      ),
    );
  }
}
