
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatever/model/user_model.dart';
import 'package:whatever/service/firebase_firestore_service.dart';

class UserController extends GetxController {
  var userModel = UserModel().obs;
  var uId = "".obs;
  final formKey = GlobalKey<FormState>();

  //underscore : private
  final fullNameController = TextEditingController();

  final emailAddressController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final passwordController = TextEditingController();

  final streetAddressController = TextEditingController();

  final emailRegexPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  var gender = "Male".obs;
  final firebaseFirestoreService = FirebaseFirestoreService();
  @override
  void onReady() {
    getUserUidFromSharedPrefs();
    super.onReady();
  }

  void getUserUidFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('uId');
    if (id != null) {
      uId.value = id;
    }
    getUserDetailsFromFirebaseUsingUID();
  }

  getUserDetailsFromFirebaseUsingUID() async {
    UserModel? userDetails;
    userDetails = await firebaseFirestoreService.getUserDetails(uId: uId.value);
    if (userDetails != null) {
      userModel.value = userDetails;
    }
  }

  ///Update User Details
  updateUserDetailsUsingUid({required BuildContext context}) async {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        if (uId.value.isNotEmpty) {
          final userModelRequest = UserModel(
            uId: uId.value,
            fullName: fullNameController.text,
            emailAddress: emailAddressController.text,
            number: phoneNumberController.text,
            address: streetAddressController.text,
            gender: gender.value,
          );
          final updatedUserModel = await FirebaseFirestoreService()
              .updateUserDetailsUsingID(
              uid: uId.value, userModel: userModelRequest);
          if (updatedUserModel != null) {
            print('User Details updated ${updatedUserModel.toJson()}');
            userModel.value = updatedUserModel;
            Navigator.of(context).pop();
          }
        }
      }
    }
  }
}
