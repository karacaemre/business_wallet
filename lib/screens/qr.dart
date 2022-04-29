import 'package:flutter/material.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR extends StatefulWidget {
  final String qrData;

  QR({Key? key, required this.qrData}) : super(key: key);

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CreateQr(qrData: widget.qrData),
                  ScanQrPage(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          padding: const EdgeInsets.all(60),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.black,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(child: Text("Show")),
            Tab(child: Text("Read")),
          ],
        ),
      ),
    );
  }
}

class CreateQr extends StatefulWidget {
  const CreateQr({Key? key, required qrData}) : super(key: key);

  @override
  State<CreateQr> createState() => _CreateQrState();
}

class _CreateQrState extends State<CreateQr> {
  @override
  Widget build(BuildContext context) {
    final qrKey = GlobalKey();
    String qrData = 'Our Qr Data';
//RepaintBoundary is necessary for saving QR to user's phone
    return Container(
      padding: const EdgeInsets.all(50),
      key: qrKey,
      child: QrImage(
        data: qrData,
        //This is the part we give data to our QR
        //  embeddedImage: , You can add your custom image to the center of your QR
        //  semanticsLabel:'', You can add some info to display when your QR scanned
        size: 250,
        backgroundColor: Colors.white,
        version: QrVersions.auto, //You can also give other versions
      ),
    );
  }
}

class ScanQrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      print(result!.code);
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.orange,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
