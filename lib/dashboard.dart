
import 'package:flutter/material.dart';
import 'package:whatever/service/firebase_auth_service.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {
          final firebaseAuthService=FirebaseAuthService();
          firebaseAuthService.signOutUser();
          Navigator.of(context).pushReplacementNamed('/login');
        },
            child: Text('Signout')),
      ),
    );
  }
}
