import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatever/controller/user_controller.dart';
import 'package:whatever/service/firebase_firestore_service.dart';

import 'model/user_model.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserController userController = Get.find();

  ///this function is used to set all controllers with their respective values
  void setControllerValuesFromUserModel(UserModel? userModel) {
    if (userModel != null) {
      if (userModel.fullName != null) {
        userController.fullNameController.text = userModel.fullName!;
      }
      if (userModel.emailAddress != null) {
        userController.emailAddressController.text = userModel.emailAddress!;
      }
      if (userModel.number != null) {
        userController.phoneNumberController.text =
            userModel.number!.toString();
      }
      if (userModel.address != null) {
        userController.streetAddressController.text = userModel.address!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? userModelDetails =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    setControllerValuesFromUserModel(userModelDetails);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Form(
        key: userController.formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: userController.fullNameController,
              keyboardType: TextInputType.name,
              maxLength: 30,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter full name',
              ),
              validator: (fullNameValue) {
                if (fullNameValue == null || fullNameValue.trim().isEmpty) {
                  return 'Please Enter Full Name';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: userController.emailAddressController,
              maxLength: 30,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email address',
              ),
              validator: (emailValue) {
                if (emailValue == null || emailValue.trim().isEmpty) {
                  return 'Please enter your email address';
                }
                final regex = RegExp(userController.emailRegexPattern);
                if (!regex.hasMatch(emailValue)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: userController.phoneNumberController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your phone number',
              ),
              validator: (phoneNumberValue) {
                if (phoneNumberValue == null ||
                    phoneNumberValue.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            TextFormField(
              controller: userController.streetAddressController,
              keyboardType: TextInputType.streetAddress,
              maxLength: 40,
              maxLines: 4,
              //lines or height of box
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your address',
              ),
              validator: (streetAddressValue) {
                if (streetAddressValue == null ||
                    streetAddressValue.trim().isEmpty) {
                  return 'Please Enter address';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text('Select your gender'),
            SizedBox(
              height: 10,
            ),
            Obx(() {
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Radio(
                      value: "Male",
                      groupValue: userController.gender.value,
                      onChanged: (newValue) {
                        if (newValue != null) {
                          userController.gender.value = newValue;
                        }
                      }),
                  Text('Male'),
                  SizedBox(
                    width: 5,
                  ),
                  Radio(
                      value: 'Female',
                      groupValue: userController.gender.value,
                      onChanged: (newValue) {
                        if (newValue != null) {
                          userController.gender.value = newValue;
                        }
                      }),
                  Text('Female'),
                ],
              );
            }),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                userController.updateUserDetailsUsingUid(context: context);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
