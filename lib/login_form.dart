import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatever/service/firebase_auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool? _isChecked = false;

  @override
  void initState() {
    print('Init state called');
    checkLoggedUsers();
    super.initState();
  }
  ///This is used to checked if user is logged in or not.
  ///If user is already logged in then firebase session exists and user object is not null and is directed to dashboard.
  checkLoggedUsers() async{
    final firebaseAuthService = FirebaseAuthService();
    final user=await firebaseAuthService.getLoggedInUser();
    if(user!=null){
      print('User signed in');
      final SharedPreferences prefs= await SharedPreferences.getInstance();
      prefs.setString('uId', user.uid);
      Navigator.of(context).pushReplacementNamed('/myApp');
    }else{
      print('User signed out');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Build called');
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your email address',
              ),
              validator: (usernameValue) {
                if (usernameValue == null || usernameValue.trim().isEmpty) {
                  return 'Please Enter username';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your password',
              ),
              validator: (passwordValue) {
                if (passwordValue == null || passwordValue.trim().isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.1,
                  child: Checkbox(
                    value: _isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked = newValue;
                      });
                      print('The value of checkbox $newValue');
                    },
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Text('Remember me on this device?')),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.4,
                  child: ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          final firebaseAuthService=FirebaseAuthService();
                          final email= _emailController.text;
                          final password= _passwordController.text;
                          final User? user= await firebaseAuthService.signInUserWithEmailAndPassword(email, password);
                          if(user!=null){
                            final SharedPreferences prefs=await SharedPreferences.getInstance();
                            await prefs.setString('uId', user.uid);
                            print('Login success');
                            Navigator.of(context).pushReplacementNamed('/myApp');
                          }
                          else{
                            print('Login failure');
                          }
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FractionallySizedBox(
                  widthFactor: 0.4,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      child: Text('Register'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
