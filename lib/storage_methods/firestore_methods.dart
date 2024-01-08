import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ivrapp/httprequests/get_ocr_result.dart';
import 'package:ivrapp/model/prescription.dart';
import 'package:ivrapp/providers/prescription_provider.dart';
import 'package:ivrapp/storage_methods/store_prescriptions.dart';
import 'package:ivrapp/widgets/showSnackBar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<String>> uploadPrescriptionDetails(
      {required BuildContext context,
      required Map<String, dynamic> filedetails}) async {
    List<String> medicines = [];
    try {
      String url = await FirebaseStorageMethods()
          .uploadtoFirestorage(context: context, filedetails: filedetails);
      String id = Uuid().v4();
      Prescription _prescription = Prescription(
          userid: _auth.currentUser!.uid,
          prescriptionUrl: url,
          uploadDate: DateTime.now().toString(),
          medicines: [],
          id: id,
          fileName: filedetails['name']);
      await _firestore
          .collection('prescriptions')
          .doc(id)
          .set(_prescription.toJson());

      medicines = await getOcrResult(prescriptionUrl: url, context: context);
      print(medicines);
      await FirestoreMethods().getPrescriptionDetails(context: context, id: id);

      // await uploadExtractedMedicines(context: context, id: id, medicines: medicines);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return medicines;
  }

  Future<void> uploadExtractedMedicines(
      {required BuildContext context,
      required String id,
      required List<String> medicines}) async {
    try {
      await _firestore
          .collection('prescriptions')
          .doc(id)
          .update({"medicines": FieldValue.arrayUnion(medicines)});

      await FirestoreMethods().getPrescriptionDetails(context: context, id: id);

    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  Future<void> getPrescriptionDetails(
      {required BuildContext context, required String id}) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('prescriptions').doc(id).get();
      Provider.of<PrescriptionProvider>(context, listen: false)
          .getPrescription(Prescription.fromSnap(snap));
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
