import 'package:cloud_firestore/cloud_firestore.dart';

class Prescription
{
  final String userid;
  final String prescriptionUrl;
  final DateTime uploadDate;
  final String medicineName;
  final String id;
  final String fileName;

  Prescription(
      {required this.userid,
        required this.prescriptionUrl,
        required this.uploadDate,
        required this.medicineName,
        required this.id,
        required this.fileName,
      });

  static Prescription fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Prescription(
        userid: snapshot["userid"],
        prescriptionUrl: snapshot["prescriptionUrl"],
        uploadDate: snapshot["uploadDate"],
        medicineName: snapshot["medicineName"],
        id: snapshot["id"],
        fileName: snapshot["fileName"],
    );
  }

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "prescriptionUrl": prescriptionUrl,
    "uploadDate": uploadDate,
    "medicineName": medicineName,
    "id": id,
    "fileName": fileName,
  };

}