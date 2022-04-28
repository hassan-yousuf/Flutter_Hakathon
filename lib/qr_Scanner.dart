import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
            Positioned(
              bottom: 10,
              child: buildResult(),
            ),
            Positioned(
              top: 10,
              child: buildControlButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildControlButtons() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(
                      snapshot.data! ? Icons.flash_on : Icons.flash_off,
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
            ),
            IconButton(
              onPressed: () async {
                await controller?.flipCamera();
              },
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(Icons.switch_camera);
                  } else {
                    return Text('');
                  }
                },
              ),
            ),
          ],
        ),
      );

  Widget buildResult() => Container(
        width: 200,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          barcode != null ? 'Result: ${barcode!.code}' : 'Scan a code!',
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
      );

  Widget buildQrView(BuildContext context) => QRView(
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderRadius: 10,
          borderLength: 20,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
      );
  final qrKey = GlobalKey(
    debugLabel: 'QR',
  );
  void onQRViewCreated(QRViewController controller) {
    setState(
      () => this.controller = controller,
    );
    controller.scannedDataStream.listen(
      (barcode) => setState(
        () => this.barcode = barcode,
      ),
    );
  }

  Barcode? barcode;

  QRViewController? controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
}
