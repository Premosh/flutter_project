
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatever/dashboard.dart';
import 'package:whatever/listpage.dart';
import 'package:whatever/listview_page.dart';
import 'package:whatever/login_form.dart';
import 'package:whatever/registration_form.dart';
import 'package:whatever/splash.dart';
import 'package:whatever/top_picks.dart';
import 'package:whatever/utilities/default_firebase_config.dart';
import 'package:whatever/utilities/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          primary: Colors.black,
          secondary: Colors.blueGrey,
          seedColor: Colors.black),
      useMaterial3: false,
    ),
    routes: {
      '/': (context) => Splash(),
      '/register': (context) => Register(),
      '/login': (context) => Login(),
      '/list': (context) => List(),
      '/listview': (context) => Listview(),
      '/topPicks': (context) => TopPicks(),
      '/myApp': (context) => MyApp(),
      '/dashboard': (context) => Dashboard(),
      '/profile': (context) => Profile(),
    },
    initialRoute: '/',
  ));
}
 void initializeFirebase() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
 }

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final pages = {
    Dashboard(),
    TopPicks(),
    Profile(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (updatedIndex){
          setState(() {
            _currentIndex=updatedIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Top Picks'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'
          ),
        ],
      ),
      body: pages.elementAt(_currentIndex),
    );
  }
}
