// signup_page.dart
import 'package:fireaddedfirst/Utility/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fireaddedfirst/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'RoundButton.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void login(){
    setState(() {
      loading = true;
    });
    // Form is valid, perform signup logic here
    _auth.createUserWithEmailAndPassword(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString()).then((value){
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
    // Navigate to HomeScreen after successful signup
    //Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  if (value == null || value == ''){
                    return 'Add a letter, Capital, digit and special Password';
                  }
                  // Check if the password contains a lowercase letter
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'Password must contain a lowercase letter';
                  }

                  // Check if the password contains an uppercase letter
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'Password must contain an uppercase letter';
                  }

                  // Check if the password contains a digit
                  if (!RegExp(r'\d').hasMatch(value)) {
                    return 'Password must contain a digit';
                  }

                  // Check if the password contains a special character
                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'Password must contain a special character';
                  }
                  return null;


                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              RoundButton(
                title: "Signup",
                loading: loading,
                onTap: () {
                  if (_formKey.currentState?.validate() == true) {
                    login();
                  }
                },

                ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Navigate to the Login page
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
