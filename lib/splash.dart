import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    // T000: implement initState
    Timer(Duration(seconds: 5),()=> Navigator.of(context).pushNamed('/login'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191F26),
      body: Center(
        child: Image.asset('assets/images/icegif-1264.gif'),
      ),
    );
  }
}
