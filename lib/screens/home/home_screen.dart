import 'package:flutter/material.dart';
import 'package:ivrapp/model/user.dart';
import 'package:ivrapp/pick_file.dart';
import 'package:ivrapp/providers/user_provider.dart';
import 'package:ivrapp/screens/crop_image/crop_image_screen.dart';
import 'package:ivrapp/storage_methods/store_prescriptions.dart';
import 'package:ivrapp/widgets/showAlert.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
    getData();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Map<String,dynamic>? filedetails;



  void getCroppedImage()async
  {
    filedetails=await Pickfile().cropImage(context: context);

    Navigator.pushNamed(context, CropImageScreen.routeName,arguments: filedetails!);
  }

  void getData()async
  {
    UserProvider _userProvider=Provider.of(context,listen: false);
    await _userProvider.getUserDetails();

  }
  @override
  Widget build(BuildContext context) {
    ModelUser user=Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(user.email),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //getCroppedImage();
          showAlert(context: context,title: '',callback: getCroppedImage);

        },
        child: Icon(Icons.add),
      ),
    );
  }
}