import 'package:cloud_firestore/cloud_firestore.dart';

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
}
