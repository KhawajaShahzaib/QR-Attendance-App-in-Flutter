import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentAttendanceListScreen extends StatefulWidget {
  final String section;
  final String classInfo;
  final String date;

  StudentAttendanceListScreen({
    required this.section,
    required this.classInfo,
    required this.date,
  });

  @override
  State<StudentAttendanceListScreen> createState() => _StudentAttendanceListScreenState();
}

class _StudentAttendanceListScreenState extends State<StudentAttendanceListScreen> {
  List<String> attendanceList = []; // Assuming student IDs are strings
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance List'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Attendances')
            .doc('${widget.section}_${widget.classInfo}_${widget.date}')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var attendanceData = snapshot.data!.data() as Map<String, dynamic>;
          attendanceList = List<String>.from(attendanceData['attendance_list']);

          return ListView.builder(
            itemCount: attendanceList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: GestureDetector(
                  onTap: () {
                    // Trigger edit operation when tapping on the text
                    _editAttendance(context, attendanceList[index], index);
                  },
                  child: Text('Student: ${attendanceList[index]}'),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteAttendance(context, index);
                  },
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  void _editAttendance(BuildContext context, String student, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        editingController.text = student;

        return AlertDialog(
          title: Text('Edit Student ID'),
          content: TextFormField(
            controller: editingController,
            decoration: InputDecoration(
              labelText: 'New Student ID',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newStudentId = editingController.text;
                setState(() {
                  attendanceList[index] = newStudentId;
                });

                // Update Firestore document with the modified attendance list
                await FirebaseFirestore.instance
                    .collection('Attendances')
                    .doc('${widget.section}_${widget.classInfo}_${widget.date}')
                    .update({'attendance_list': attendanceList});

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAttendance(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Student ID'),
          content: Text('Are you sure you want to delete this student ID?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  attendanceList.removeAt(index);
                });

                // Update Firestore document with the modified attendance list
                await FirebaseFirestore.instance
                    .collection('Attendances')
                    .doc('${widget.section}_${widget.classInfo}_${widget.date}')
                    .update({'attendance_list': attendanceList});

                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
