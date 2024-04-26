import 'dart:io';

import 'package:blyss/src/helper/blyssIcons_icons.dart';
import 'package:blyss/src/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../catalog/product.dart';
import '../catalog/product_main_view.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  static const routeName = '/qr-scanner';

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            top: 0,
            left: 8,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(BlyssIcons.xmark, size: 16),
                onPressed: () => Navigator.of(context).pop(),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: ColorStyle.accentRed,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      handleScannedData(result!.code);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No permission for camera access')),
      );
    }
  }

  void handleScannedData(String? data) {
    int? productId = int.tryParse(data!);
    if (productId == null) {
      return;
    }
    Product product = Product.getProductById(productId);
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      ProductPage.routeName,
      arguments: product,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
