import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String qrResult = 'Scanned Data will appear here';

  Future<void> scanQr() async {
    try {
      // Scan the QR code and get the result
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR, 2, 'CameraFace.front');
      if (!mounted) return; // Ensure the widget is still in the tree

      setState(() {
        // Update the qrResult with the scanned code or if scan was cancelled
        qrResult = qrCode == '-1' ? 'Scan cancelled' : qrCode;
      });
    } on PlatformException {
      setState(() {
        qrResult = "Failed to read QR code";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              qrResult,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: scanQr,
              child: Text('Scan Code'),
            ),
          ],
        ),
      ),
    );
  }
}
