// profile_edit_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Fetch the current user's email and populate the text field
    _emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Showing Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: Key('emailTextFieldKey'),
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(
                // color: Colors.white,
              )),
              style: TextStyle(
                // color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await _updateEmail();
              },
              child: Text('Update Email'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 30,),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateEmail(_emailController.text);
        // Reload the user to get the updated profile
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        setState(() {
          _errorMessage = '';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email updated successfully'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
      });
    }
  }
}
