// main.dart
import 'package:fireaddedfirst/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fireaddedfirst/home_screen.dart';
import 'package:fireaddedfirst/signup_page.dart';
import 'package:fireaddedfirst/login_page.dart';
import 'package:fireaddedfirst/qr_form_screen.dart';
import 'package:fireaddedfirst/qr_result_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'googleMaps.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Attendance App',
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple,
        ),
      ),
      home: SplashScreen(),
      // initialRoute: '/splash_screen',
      routes: {
        '/signup': (context) => SignupPage(),
        '/splash_sreen':(context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/qr_form': (context) => QRFormScreen(),
        // '/qr_result': (context) => QRResultScreen(),
        '/googleMaps': (context) => MapPage(),


      },
    );
  }
}
