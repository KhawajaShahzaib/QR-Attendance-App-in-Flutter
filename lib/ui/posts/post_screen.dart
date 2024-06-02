import 'package:fireaddedfirst/RoundButton.dart';
import 'package:fireaddedfirst/Utility/utils.dart';
import 'package:fireaddedfirst/home_screen.dart';
import 'package:fireaddedfirst/login_page.dart';
import 'package:fireaddedfirst/view_attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("post_screen"),
       actions: [
         IconButton(onPressed: (){
          final auth = FirebaseAuth.instance;
          auth.signOut().then((value){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          }).onError((error, stackTrace) {
            Utils().toastMessage(error.toString());
          });
         }, icon: Icon(Icons.logout_rounded),),
         SizedBox(width: 25,)
       ],
      ),
      body: Center(
        child:     RoundButton(

          title: "Go to HomeScreen",
          onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },

        ),
      ),
    );
  }
}
