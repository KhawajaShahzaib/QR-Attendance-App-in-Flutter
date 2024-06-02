import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireaddedfirst/student_list.dart';
import 'package:flutter/material.dart';

import 'attendance_details_screen.dart';


class ViewAttendanceScreen extends StatefulWidget {
  @override
  _ViewAttendanceScreenState createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  List<String> allAttendanceDates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance List'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Attendances').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<Widget> attendanceWidgets = [];
          var attendances = snapshot.data!.docs;

          for (var attendance in attendances) {
            var attendanceData = attendance.data() as Map<String, dynamic>;

            attendanceWidgets.add(
              ListTile(
                title: Text('Section: ${attendanceData['section']} - Class: ${attendanceData['class']}'),
                subtitle: Text('Date: ${attendanceData['date']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentAttendanceListScreen(
                        section: attendanceData['section'],
                        classInfo: attendanceData['class'],
                        date: attendanceData['date'],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return ListView(
            children: attendanceWidgets,
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
