import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BarcodeScannerScreen(),
    );
  }
}

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String barcodeResult = 'Scan a barcode';

  // Updated function to accept BarcodeCapture
  void onBarcodeDetected(BarcodeCapture capture) {
    final barcode = capture.barcodes.first;
    setState(() {
      barcodeResult = barcode.rawValue ?? 'Unknown Barcode';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: onBarcodeDetected, // Use onBarcodeDetected directly
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black,
            child: Text(
              barcodeResult,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
