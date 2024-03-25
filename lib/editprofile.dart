import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatever/service/firebase_firestore_service.dart';

import 'model/user_model.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  //underscore : private
  final _fullNameController = TextEditingController();

  final _emailAddressController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _passwordController = TextEditingController();

  final _streetAddressController = TextEditingController();

  final _emailRegexPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  String gender = "Male";

  @override
  void initState() {
    super.initState();
  }

  ///this function is used to set all controllers with their respective values
  void setControllerValuesFromUserModel(UserModel? userModel) {
    if (userModel != null) {
      if (userModel.fullName != null) {
        _fullNameController.text = userModel.fullName!;
      }
      if (userModel.emailAddress != null) {
        _emailAddressController.text = userModel.emailAddress!;
      }
      if (userModel.number != null) {
        _phoneNumberController.text = userModel.number!.toString();
      }
      if (userModel.address != null) {
        _streetAddressController.text = userModel.address!;
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
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _fullNameController,
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
              controller: _emailAddressController,
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
                final regex = RegExp(_emailRegexPattern);
                if (!regex.hasMatch(emailValue)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneNumberController,
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
              controller: _streetAddressController,
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
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Radio(
                    value: "Male",
                    groupValue: gender,
                    onChanged: (newValue) {
                      setState(() {
                        if (newValue != null) {
                          gender = newValue;
                        }
                      });
                    }),
                Text('Male'),
                SizedBox(
                  width: 5,
                ),
                Radio(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (newValue) {
                      setState(() {
                        if (newValue != null) {
                          gender = newValue;
                        }
                      });
                    }),
                Text('Female'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState != null) {
                  if (_formKey.currentState!.validate()) {
                    // Obtain shared preferences.
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final uId = prefs.getString('uId');
                    if (uId != null) {
                      final userModelRequest = UserModel(
                        uId: uId,
                        fullName: _fullNameController.text,
                        emailAddress: _emailAddressController.text,
                        number: _phoneNumberController.text,
                        address: _streetAddressController.text,
                        gender: gender,
                      );
                      final updatedUserModel = await FirebaseFirestoreService()
                          .updateUserDetailsUsingID(
                              uid: uId, userModel: userModelRequest);
                      if (updatedUserModel != null) {
                        print('User Details updated');
                        Navigator.of(context).pop();
                      }
                    }
                  }
                }
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
