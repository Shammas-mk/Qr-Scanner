import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_scanner/pages/qr_page.dart';
import 'package:qr_scanner/show_back_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController qrText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String qrCode = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await ShowBackWarning().showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Qr Scanner'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(qrCode),
                const SizedBox(height: 25),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter SomeThing To Generate QR Code';
                    }
                    return null;
                  },
                  controller: qrText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Generate a QR Code'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    QrPage(text: qrText.text)),
                            (route) => false);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Scan a QR Code'),
                    onPressed: () {
                      scanQr();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  scanQr() async {
    String scannedText = '';
    try {
      scannedText = await FlutterBarcodeScanner.scanBarcode(
          '', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      scannedText = 'Somthing went Wrong';
    }
    if (!mounted) return;
    setState(() {
      qrCode = scannedText;
    });
  }
}
