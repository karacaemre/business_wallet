import 'package:business_wallet/http/remote.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import '../model/user.dart';

class QR extends StatelessWidget {
  const QR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context, "Cancel");
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CreateQr(qrData: Remote.user.toJson().toString()),
                  const ScanQrPage(),
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
            Tab(child: Text("Scan")),
          ],
        ),
      ),
    );
  }
}

class CreateQr extends StatefulWidget {
  final String qrData;

  const CreateQr({Key? key, required this.qrData}) : super(key: key);

  @override
  State<CreateQr> createState() => _CreateQrState();
}

class _CreateQrState extends State<CreateQr> {
  @override
  Widget build(BuildContext context) {
    final qrKey = GlobalKey();
    String qrData = widget.qrData;
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
        backgroundColor: Colors.transparent,
        version: QrVersions.auto, //You can also give other versions
      ),
    );
  }
}

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  Barcode? result;
  User? contactInfo;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
    String newPossibleContact = result!.code.toString();
    if (result != null) {
      contactInfo = json.decode(newPossibleContact);
      controller!.pauseCamera();
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return Stack(
      children: <Widget>[
        QRView(
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
        Positioned(bottom: 10, child: scanResult())
      ],
    );
  }

  Widget scanResult() => Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          Text(
            result != null ? 'Result: ${result!.code}' : "Scan a QR Code",
            maxLines: 3,
          ),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {},
                child: const Text('Add to Contacts'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: null,
                child: const Text(''),
              ),
            ],
          ),
        ],
      ));
}
