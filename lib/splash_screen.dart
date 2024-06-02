import 'package:fireaddedfirst/ui/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("Hello",
          style: TextStyle(fontSize: 56, color: Colors.purple),),),
    );
  }
}
