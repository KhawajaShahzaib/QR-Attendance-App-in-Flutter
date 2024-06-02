import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Attendance App',
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Attendance App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: sectionController,
              decoration: InputDecoration(labelText: 'Section'),
            ),
            TextField(
              controller: classController,
              decoration: InputDecoration(labelText: 'Class'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await startAttendance(context);
              },
              child: Text('Start Attendance'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startAttendance(BuildContext context) async {
    final String section = sectionController.text;
    final String classInfo = classController.text;
    final String date = dateController.text;

    // Add your authentication check here if needed

    // Create a document in Firestore
    await FirebaseFirestore.instance.collection('Attendances').doc('$section' + '_' + '$classInfo' + '_' + '$date').set({

      'section': section,
      'class': classInfo,
      'date': date,
      'attendance_list': [], // Initialize with an empty array
    });

    // Show success message or navigate to the next screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Attendance started for $section - $classInfo on $date'),
      ),
    );
  }
}
