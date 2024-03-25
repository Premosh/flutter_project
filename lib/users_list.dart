import 'package:flutter/material.dart';
import 'package:whatever/service/firebase_firestore_service.dart';
import 'model/user_model.dart';
class usersList extends StatelessWidget {
  const usersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: FirebaseFirestoreService().getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              ///connection established but has error
              if (snapshot.hasError) {
                return Center(
                  child: Text('No user found'),
                );
              }

              ///connection established and has data
              if (snapshot.hasData) {
                final usersList = snapshot.data;
                if (usersList != null) {
                  return ListView.builder(
                      itemCount: usersList.length,
                      itemBuilder: (context, index) {
                        final userModelDetails = usersList[index];
                        return BasicDetails(
                          userModel: userModelDetails,
                        );
                      });
                } else {
                  return Center(
                    child: Text('Users not found'),
                  );
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class BasicDetails extends StatelessWidget {
  BasicDetails({required this.userModel});

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(
                    0,
                    3,
                  ), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (userModel != null)
                    ? Text('Name: ${userModel!.fullName}')
                    : Text('Name:-'),
                SizedBox(
                  height: 5,
                ),
                (userModel != null)
                    ? Text('Email: ${userModel!.emailAddress}')
                    : Text('Email: -'),
                SizedBox(
                  height: 5,
                ),
                (userModel != null)
                    ? Text('Phone: ${userModel!.number}')
                    : Text('Phone: -'),
                SizedBox(
                  height: 5,
                ),
                (userModel != null)
                    ? Text('Address: ${userModel!.address}')
                    : Text('Address: -'),
                SizedBox(
                  height: 5,
                ),
                (userModel != null)
                    ? Text('Gender: ${userModel!.gender}')
                    : Text('Gender: -'),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async{
                showDialog(context: context, builder: (dialogContext){
                  return AlertDialog(
                    icon: Icon(Icons.warning),
                    title: Text('Delete user'),
                    content: Text('Are you sure you want to delete the user?'),
                    actions: [
                      TextButton(onPressed: () async{
                        final firebaseFirestore=FirebaseFirestoreService();
                        if(userModel!=null){
                          if(userModel!.uId!=null){
                            await firebaseFirestore.deleteUserUsingUid(uid: userModel!.uId!);
                            Navigator.of(context).pushNamed('/profile');
                          }
                        }
                      }, child: Text('Yes')),
                      TextButton(onPressed: (){
                        Navigator.of(dialogContext).pop();
                      }, child: Text('No')),
                    ],
                  );
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
