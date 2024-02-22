import 'package:flutter/material.dart';
import 'package:whatever/service/firebase_auth_service.dart';
import 'package:whatever/service/firebase_firestore_service.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  List<dynamic> users= [];

  @override
  Widget build(BuildContext dashboardContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await showDialog(
                  context: dashboardContext,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      icon: Icon(Icons.warning),
                      title: Text('Signout User'),
                      content: Text('Are you sure you want to signout?'),
                      actions: [
                        GestureDetector(
                          child: Text('Yes'),
                          onTap: () {
                            final firebaseAuthService = FirebaseAuthService();
                            firebaseAuthService.signOutUser();
                            Navigator.of(dialogContext).pop();
                            Navigator.of(dashboardContext)
                                .pushReplacementNamed('/login');
                          },
                        ),
                        GestureDetector(
                          child: Text('No'),
                          onTap: () {
                            Navigator.of(dialogContext).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
            child: Text('Signout'),
          )
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestoreService().getAllUser(),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Icon(Icons.warning),
            );
          }
          if(snapShot.connectionState == ConnectionState.done){
            users=snapShot.data as List;
            return Center(child: Text('The users is ${users[0]}'),
            );
          }
          return SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
