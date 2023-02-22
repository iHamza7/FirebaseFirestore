// ignore_for_file: avoid_print, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';

import 'usermodel.dart';

class FirestoreHelper {
  static Stream<List<UserModel>> read() {
    final usercollection = FirebaseFirestore.instance.collection("finderList");
    return usercollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  static Future addData(UserModel user) async {
    final usercollection = FirebaseFirestore.instance.collection("finderList");

    final docRef = usercollection.doc(user.finderName);

    final newUser = UserModel(
      finderName: user.finderName,
      finderEmail: user.finderEmail,
      finderAddress: user.finderAddress,
      finderPhone: user.finderPhone,
    ).toJson();

    try {
      await docRef.set(newUser).whenComplete(() {
        print("${user.finderName} created ");
      });
    } catch (e) {
      print("error occur $e");
    }
  }
}
