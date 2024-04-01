import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatever/model/user_model.dart';
import 'package:whatever/service/firebase_firestore_service.dart';

class UserController extends GetxController {
  var userModel = UserModel().obs;
  var uId = "".obs;
  final firebaseFirestoreService= FirebaseFirestoreService();
  @override
  void onReady() {
    getUserUidFromSharedPrefs();
    super.onReady();
  }

  void getUserUidFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('uId');
    if(id!=null){
      uId.value=id;
    }
    getUserDetailsFromFirebaseUsingUID();
  }
  getUserDetailsFromFirebaseUsingUID()async{
    UserModel? userDetails;
    userDetails = await firebaseFirestoreService.getUserDetails(uId: uId.value);
    if(userDetails!=null){
      userModel.value=userDetails;
    }
  }
}
