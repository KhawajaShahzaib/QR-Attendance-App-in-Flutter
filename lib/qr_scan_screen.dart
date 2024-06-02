import 'package:fireaddedfirst/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentAttendanceScreen extends StatefulWidget {
  final String qrCodeData;

  StudentAttendanceScreen({required this.qrCodeData});

  @override
  _StudentAttendanceScreenState createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  final TextEditingController sapIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scan the QR Code and enter your SAP ID:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Display the QR Code data (you can use QrImageView here if needed)
            Text(
              widget.qrCodeData,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: sapIdController,
              decoration: InputDecoration(
                labelText: 'Enter SAP ID',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                submitAttendance();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
                // Navigator.pushNamed(context, MaterialPageRoute(builder: builder))
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('Submit Attendance', style: TextStyle(
                color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitAttendance() async {
    String sapId = sapIdController.text;
    String qrCodeData = widget.qrCodeData;

    // Split the qrCodeData to get section, class, and date
    List<String> qrCodeDataParts = qrCodeData.split('_');
    String section = qrCodeDataParts[0];
    String classInfo = qrCodeDataParts[1];
    String date = qrCodeDataParts[2];

    // Retrieve the attendance document from Firestore
    DocumentSnapshot attendanceSnapshot = await FirebaseFirestore.instance.collection('Attendances').doc('$section' + '_' + '$classInfo' + '_' + '$date').get();

    // Retrieve the timestamp from the document
    Timestamp timestamp = attendanceSnapshot['timestamp'];

    // Calculate the time difference in seconds
    int timeDifference = Timestamp.now().seconds - timestamp.seconds;

    // Check if more than 2 minutes have passed
    if (timeDifference > 600) {
      print("Time is greater");
      // Show a message or handle accordingly
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance period has expired.'),
        ),
      );
    } else {
      print("Current Time:");
      print(Timestamp.now());
      // Update the attendance array in Firestore
      await FirebaseFirestore.instance.collection('Attendances').doc('$section' + '_' + '$classInfo' + '_' + '$date').update({
        'attendance_list': FieldValue.arrayUnion([sapId]),
      });

      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance submitted successfully for SAP ID: $sapId'),
        ),
      );
    }
  }
}
