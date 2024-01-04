import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ivrapp/httprequests/get_ocr_result.dart';
import 'package:ivrapp/model/prescription.dart';
import 'package:ivrapp/storage_methods/store_prescriptions.dart';
import 'package:ivrapp/widgets/showSnackBar.dart';
import 'package:uuid/uuid.dart';
class FirestoreMethods {

  Future<void> uploadPrescriptionDetails(
      {required BuildContext context,
      required Map<String, dynamic> filedetails}) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      String url = await FirebaseStorageMethods()
          .uploadtoFirestorage(context: context, filedetails: filedetails);
      String id=Uuid().v4();
      Prescription _prescription = Prescription(
          userid: _auth.currentUser!.uid,
          prescriptionUrl: url,
          uploadDate: DateTime.now(),
          medicineName: '',
          id: id,
          fileName: filedetails['name']);
      await _firestore.collection('prescriptions').doc(id).set(_prescription.toJson());
      await getOcrResult(prescriptionUrl: url, context: context);


    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
