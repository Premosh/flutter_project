
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
            child: Text('Signout')),
      ),
    );
  }
}
