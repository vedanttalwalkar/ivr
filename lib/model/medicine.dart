import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine
{
  final String medicineName;
  final int quantity;
  Medicine({required this.medicineName,required this.quantity});

  static Medicine fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Medicine(
      medicineName: snapshot["medicineName"],
      quantity: snapshot["quantity"],

    );
  }

  Map<String, dynamic> toJson() => {
    "medicineName": medicineName,
    "quantity": quantity,
  };

  static Medicine fromMap(Map<String,dynamic> snapshot) {
    return Medicine(
      medicineName: snapshot["medicineName"],
      quantity: snapshot["quantity"],

    );
  }

}