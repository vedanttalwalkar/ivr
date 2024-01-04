import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:ivrapp/pick_file.dart';

class FirebaseStorageMethods {
  Future<String> uploadtoFirestorage({required BuildContext context,required Map<String,dynamic> filedetails}) async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    final User _user=FirebaseAuth.instance.currentUser!;
    String filename = filedetails['name'];
    print('on image storage'+_user.uid+'filename'+filedetails['name']);
    Reference _ref =
        _storage.ref().child('prescriptions/').child(_user.uid).child(filename);
    UploadTask uploadTask = _ref.putFile(filedetails['file']);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
