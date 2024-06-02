import 'package:fireaddedfirst/qr_scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _qrController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {

    setState(() {
      _qrController = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      // Handle the scanned QR Code data
      _onQRCodeScanned(scanData);
    });
  }

  void _onQRCodeScanned(Barcode? scanData) async {
    // Get the raw text data from the scanned QR Code, or provide a default value
    String qrCodeData = scanData?.code ?? '';

    // Get the current location
    Position position = await _getCurrentLocation();

    // Check if the user is at a specific location (replace with your own logic)
    if (await Permission.location.request().isGranted) {
      if (_isUserAtSpecificLocation(position)) {
        // Navigate to the StudentAttendanceScreen with the scanned QR Code data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentAttendanceScreen(qrCodeData: qrCodeData),
          ),
        );
      } else {
        // User is not at the specific location, show a message or handle accordingly
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You are not at the specific location."),
          ),
        );
      }
    }
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  bool _isUserAtSpecificLocation(Position position) {
    // Replace these values with the coordinates of your specific location
    double targetLatitude = 31.3773888; // Example latitude
    double targetLongitude = 74.2307665; // Example longitude

    // Define a threshold (in meters) within which you consider the user to be at the specific location
    double threshold = 500.0; // Example threshold: 50 meters

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

  @override
  void dispose() {
    _qrController.dispose();
    super.dispose();
  }
}

