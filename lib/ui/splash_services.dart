import 'dart:async';

import 'package:fireaddedfirst/login_page.dart';
import 'package:fireaddedfirst/ui/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';

class SplashServices {

  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      print(user.email.toString());
      Timer(const Duration(seconds: 3),()=> Navigator.push(context,
  MaterialPageRoute(builder: (context) => HomeScreen())
    ));
  }
    else{
      Timer(const Duration(seconds: 3),()=> Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginPage())
      ));
    }
  }
}