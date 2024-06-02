import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


class QRResultScreen extends StatefulWidget {
  final String qrCodeValue;

  // final String data;
  QRResultScreen({required this.qrCodeValue});

  @override
  _QRResultScreenState createState() => _QRResultScreenState();
}

class _QRResultScreenState extends State<QRResultScreen> {
  String qrData = "Your QR Code Data";
  // final String qrCodeValue = '$section' + '_' + '$classInfo' + '_' + '$date';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Result'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if(await Permission.location.serviceStatus.isEnabled){
                      var status = await Permission.location.status;
                      if(status.isGranted){
                        print("GRANTEd BROOOO HEREEEEEEEE");
                      }
                      else{
                        Map<Permission, PermissionStatus> status = await [
                          Permission.location,
                        ].request();
                      }
                      Position position = await _getCurrentLocation();

                      // Check if the user is at a specific location (replace with your own logic)
                      if (_isUserAtSpecificLocation(position)) {
                        // Generate a new QR code based on the location
                        String newQrData = "Location QR Code Data: ${position.latitude}, ${position.longitude}";

                        // Update the QR code data and rebuild the widget
                        setState(() {
                          qrData = newQrData;
                        });

                        // Reload the QRResultScreen
                        Navigator.of(context).popAndPushNamed('/qr_result');
                      } else {
                        // User is not at the specific location, show a message or handle accordingly
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("You are not at the specific location."),
                          ),
                        );
                      }
                    }
                    // Get the current location

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                  ),
                  child: Text('Generate QR'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add logic to share the QR code
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  child: Text('Share'),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  bool _isUserAtSpecificLocation(Position position) {
    // Replace these values with the coordinates of your specific location
    double targetLatitude = 37.7749; // Example latitude
    double targetLongitude = -122.4194; // Example longitude

    // Define a threshold (in meters) within which you consider the user to be at the specific location
    double threshold = 50.0; // Example threshold: 50 meters

    // Calculate the distance between the user's location and the target location
    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      targetLatitude,
      targetLongitude,
    );

    // Check if the distance is within the threshold
    return distance <= threshold;
  }
}
