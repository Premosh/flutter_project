import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uId;
  String? fullName;
  String? emailAddress;
  String? number;
  String? address;
  String? gender;

  UserModel(
      {this.uId,
      this.fullName,
      this.emailAddress,
      this.number,
      this.address,
      this.gender});

  toJson() {
    return {
      'id': uId,
      'fullName': fullName,
      'email': emailAddress,
      'contact': number,
      'address': address,
      'gender': gender
    };
  }

  factory UserModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final userData = document.data();
    return UserModel(
      uId: userData['id'],
      fullName: userData['fullName'],
      emailAddress: userData['email'],
      number: userData['contact'],
      address: userData['address'],
      gender: userData['gender'],
    );
  }
}
