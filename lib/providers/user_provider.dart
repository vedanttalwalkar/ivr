import 'package:flutter/cupertino.dart';
import 'package:ivrapp/model/user.dart';
import 'package:ivrapp/screens/auth/services/auth_services.dart';

class UserProvider extends ChangeNotifier
{
  ModelUser _user=ModelUser(username: '', email: '', userid: '', phoneNumber: '', address: '');
  ModelUser get user=>_user;

  Future<void> getUserDetails()async
  {
    _user=await AuthServices().getUserDetails();
    notifyListeners();
  }

}