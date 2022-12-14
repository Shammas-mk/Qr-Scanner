import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/pages/home_page.dart';
import 'package:qr_scanner/show_back_alert.dart';

class QrPage extends StatelessWidget {
  const QrPage({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await ShowBackWarning().showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 300,
                    child: QrImage(
                      data: text,
                      version: QrVersions.auto,
                      gapless: false,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20)
                        .copyWith(bottom: 40),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  child: const Text("Generate or Scan New"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20)
                        .copyWith(bottom: 40),
                child: const Text('Scan the Qr for more information'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
