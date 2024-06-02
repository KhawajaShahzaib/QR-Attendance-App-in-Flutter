import 'package:fireaddedfirst/qr_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRFormScreen extends StatefulWidget {
  @override
  State<QRFormScreen> createState() => _QRFormScreenState();
}

class _QRFormScreenState extends State<QRFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  String section = '';
  String classInfo = '';
  String date = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: sectionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a section';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter section',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: classController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a class';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter class',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    section = sectionController.text;
                    classInfo = classController.text;
                    date = DateTime.now().toString();

                    await startAttendance(context);

                    String qrCodeValue = '$section' + '_' + '$classInfo' + '_' + '$date';

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRResultScreen(qrCodeValue: qrCodeValue)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: Text(
                  'Generate QR Code',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> startAttendance(BuildContext context) async {
    Timestamp timestamp = Timestamp.now();

    await FirebaseFirestore.instance.collection('Attendances').doc('$section' + '_' + '$classInfo' + '_' + '$date').set({
      'section': section,
      'class': classInfo,
      'date': date,
      'timestamp': timestamp,
      'attendance_list': [],
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Attendance started for $section - $classInfo on $date'),
      ),
    );
  }
}
