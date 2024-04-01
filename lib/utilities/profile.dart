import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatever/controller/user_controller.dart';
import 'package:whatever/model/user_model.dart';
import 'package:whatever/service/firebase_firestore_service.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('View Profile'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/usersList'),
              icon: Icon(Icons.people))
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: (userController.uId.value.isNotEmpty)
              ? ListView(
                  children: [
                    ProfileImage(),
                    SizedBox(
                      height: 20,
                    ),
                    BasicDetails(
                      userModel: userController.userModel.value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MenuWidgets(
                      title: 'Settings',
                      onPressed: () {
                        print('Settings Clicked');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MenuWidgets(
                      title: 'Notifications',
                      onPressed: () {
                        print('Notifications Clicked');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MenuWidgets(
                      title: 'About App',
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      }),
    );
  }
}

///This widget is used to display the circular profile images
class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/raiden.gif'),
      ),
    );
  }
}

///This is the widget for displaying the basic details of the user
class BasicDetails extends StatelessWidget {
  BasicDetails({required this.userModel});

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(
              0,
              3,
            ), // changes position of shadow
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (userModel != null)
              ? Text('Name: ${userModel!.fullName}')
              : Text('Name:-'),
          SizedBox(
            height: 5,
          ),
          (userModel != null)
              ? Text('Email: ${userModel!.emailAddress}')
              : Text('Email: -'),
          SizedBox(
            height: 5,
          ),
          (userModel != null)
              ? Text('Phone: ${userModel!.number}')
              : Text('Phone: -'),
          SizedBox(
            height: 5,
          ),
          (userModel != null)
              ? Text('Address: ${userModel!.address}')
              : Text('Address: -'),
          SizedBox(
            height: 5,
          ),
          (userModel != null)
              ? Text('Gender: ${userModel!.gender}')
              : Text('Gender: -'),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed('/editProfile', arguments: userModel),
              child: Text('Edit Profile')),
        ],
      ),
    );
  }
}

///This widget is common for creating menus
class MenuWidgets extends StatelessWidget {
  MenuWidgets({required this.title, this.onPressed});

  String title;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(
                0,
                3,
              ), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
