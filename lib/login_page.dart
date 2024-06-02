import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Utility/utils.dart';
import 'ui/posts/post_screen.dart';
import 'home_screen.dart';
import 'RoundButton.dart';  // Assuming RoundButton is in the same directory

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  void login() {
  setState(() {
    loading = true;
  });
    _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())
      );
      setState(() {
        loading = false;
      });
      // Handle successful login here if needed
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });

    // Navigate to HomeScreen after successful signup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add more email validation if needed
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  // You can add more password validation if needed
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 16),
              RoundButton(
                loading: loading,

                title: "Login",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                    // Navigator.pushReplacementNamed(context, '/home');
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  // Navigate to the Login page
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Are u a new User? Signup Here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
