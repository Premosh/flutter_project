import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

//This function is for creating a user with email and password in firebase
  Future<User?> signUpUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('Something went wrong!!');
    }
    return null;
  }

  //This function is for login using created user.
  Future<User?> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('Login Failed');
    }
    return null;
  }

  void signOutUser() async {
    await _auth.signOut();
  }
}
