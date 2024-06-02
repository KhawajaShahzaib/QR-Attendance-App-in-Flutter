// pin_screen.dart
import 'package:flutter/material.dart';
import 'package:fireaddedfirst/qr_form_screen.dart';

import 'home_screen.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Teacher Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter PIN',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Check if the entered PIN is correct
                if (pinController.text == '111') {
                  // Navigate to QRFormScreen if the PIN is correct
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => QRFormScreen()),
                  );
                } else {
                  // Show an error message or handle incorrect PIN
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Incorrect PIN. Please try again.'),
                    ),

                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
