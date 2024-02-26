import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatever/model/user_model.dart';

class FirebaseFirestoreService {
  final firebaseFirestore = FirebaseFirestore.instance;
  final usersList = [];

  Future getSingleUser() async {
    try {
      CollectionReference _userCollection =
          await firebaseFirestore.collection('users');
      final userDoc = await _userCollection.doc('user1').get();
      if (userDoc.exists) {
        print('The User details is ${userDoc.data()}');
      } else {
        print('Error getting user info');
      }
    } catch (e) {
      print('Error getting user info $e');
    }
  }

  ///This is used to get all users from user collection.
  Future getAllUser() async {
    try {
      CollectionReference _userCollections =
          await firebaseFirestore.collection('users');
      await _userCollections.get().then((QuerySnapshot) {
        for (var doc in QuerySnapshot.docs) {
          usersList.add(doc.data());
        }
      });
      return usersList;
    } catch (e) {
      print('Error getting user details $e');
    }
  }

  ///Function to create user from firebase.
  void signUpUser({required UserModel userModel}) async {
    try {
      CollectionReference _usersCollection =
          await firebaseFirestore.collection('users');
      await _usersCollection
          .add(userModel.toJson())
          .whenComplete(() => print('User Created'));
    } catch (e) {
      print('Something went wrong :( !!!');
    }
  }

  ///This is to get user details according to id.
  Future<UserModel?> getUserDetails({required String uId}) async {
    try {
      final CollectionReference _userCollectionReference =
          await firebaseFirestore.collection('users');
      final documentSnapshot =
          await _userCollectionReference.where('id', isEqualTo: uId).get();
      if (documentSnapshot.docs.isNotEmpty) {
        final userModel = documentSnapshot.docs
            .map((doc) => UserModel.fromJson(
                doc as QueryDocumentSnapshot<Map<String, dynamic>>))
            .first;
        return userModel;
      } else {
        print('Document not found........');
      }
    } catch (e) {
      print('Something went wrong');
    }
  }
}
