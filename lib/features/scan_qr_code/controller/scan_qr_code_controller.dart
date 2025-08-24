import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/services/subscriber_services.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/supescriber_model.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanQrCodeController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedData;
  SubscriberServices userServices = SubscriberServices();

  ImageProvider? provider;

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      scannedData = scanData.code;
      final firstLine = scannedData?.split('\n').first ?? '';
      int? parsedInt;
      try {
        parsedInt = int.parse(firstLine);
        final SupescriberModel? user = await userServices.getUserById(
          parsedInt.toString(),
        );
        if (user != null) {
          if (user.imagePath.startsWith('assets/')) {
            provider = AssetImage(user.imagePath);

            update();
          } else {
            provider = FileImage(File(user.imagePath));

            update();
          }
        }
      } catch (e) {
        print('First line is not a valid int: $firstLine');
      }
      update();
    });
  }
}
