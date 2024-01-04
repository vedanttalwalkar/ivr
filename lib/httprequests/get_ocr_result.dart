import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ivrapp/constants.dart';
import 'package:ivrapp/widgets/http_error_handling.dart';
import 'package:ivrapp/widgets/showSnackBar.dart';

Future<void> getOcrResult(
    {required String prescriptionUrl, required BuildContext context}) async {
  try {
    http.Response res = await http.post(
      Uri.parse('https://b9c3-103-117-185-144.ngrok-free.app/get-ocr'),
      body: jsonEncode({
        "url": prescriptionUrl,
      }),
    );

    httpErrorhandle(
        context: context,
        res: res,
        onSuccess: () {
          print('result will be');
          print(jsonDecode(res.body));
        });
  } on SocketException catch (err) {
    print(err.toString());
    showSnackBar(context, err.toString());
  }
}
