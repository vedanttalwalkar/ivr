import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:ivrapp/constants.dart';
import 'package:ivrapp/model/user.dart';
import 'package:ivrapp/providers/user_provider.dart';
import 'package:ivrapp/screens/auth/services/auth_services.dart';
import 'package:ivrapp/screens/chatscreen/chatscreen.dart';
import 'package:ivrapp/screens/home/drawer_screens/services/orders_services.dart';
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

  void addOrder() async {
    await OrderServices().uploadOrder(context: context);
  }

  void makeCall() async {
    // final Uri url = Uri(scheme: "tel", path: phoneNum);
    // try {
    //   if (await canLaunchUrl(url)) {
    //     await launchUrl(url);
    //   }
    // } catch (e) {
    //   print(e);
    // }
    FlutterPhoneDirectCaller.callNumber(phoneNum);
  }

  @override
  Widget build(BuildContext context) {
    ModelUser user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      drawer: showDrawer(context: context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          makeCall();
        },
        child: Icon(
          Icons.phone,
          color: Colors.black,
        ),
      ),
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
