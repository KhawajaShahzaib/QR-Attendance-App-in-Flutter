// home_screen.dart
import 'package:fireaddedfirst/pin_screen.dart';
import 'package:fireaddedfirst/profile_edit_screen.dart';
import 'package:fireaddedfirst/qrscan.dart';
import 'package:fireaddedfirst/view_attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fireaddedfirst/qr_form_screen.dart';

import 'Utility/utils.dart';
import 'googleMaps.dart';
import 'login_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Attendance App'),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEditScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.face),
              title: Text('Generate QR Code'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PinScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.face),
              title: Text('Scan QR-Code'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScannerScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('View Attendance'),
              onTap: () {
                // Add your logic to navigate to the user profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewAttendanceScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help and Suppot'),
              onTap: () {
                // Add your logic to show help and support information
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Help and Support'),
                    content: Text(
                      'If you need assistance or have any questions, please contact our support team at info@AK-Solutions.net.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Add more ListTile widgets for additional buttons
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the QR Scanner App!',
              style: TextStyle(fontSize: 20,),
            ),
            SizedBox(height: 20),
            Text(
              'Hassle-Free Attendance.',
              style: TextStyle(fontSize: 16, color: Colors.deepPurple),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('About Us'),
                    content: Text(
                      'Face Detector App\nVersion 1.0\n\nDeveloped by AK-Solution',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('About Us',
                style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Face Detector in Future',
          ),
        ],
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MapPage()),
          );
          // Add your navigation logic here
        },
      ),
    );
  }
}
