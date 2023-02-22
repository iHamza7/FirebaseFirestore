import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? finderName, finderEmail, finderAddress;
  double? finderPhone;

  UserModel(
      {this.finderName,
      this.finderEmail,
      this.finderAddress,
      this.finderPhone});

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      finderName: snapshot["finderName"],
      finderEmail: snapshot["finderEmail"],
      finderAddress: snapshot["finderAddress"],
      finderPhone: snapshot["finderPhone"],
    );
  }
  Map<String, dynamic> toJson() => {
        "finderName": finderName,
        "finderEmail": finderEmail,
        "finderAddress": finderAddress,
        "finderPhone": finderPhone,
      };
}
