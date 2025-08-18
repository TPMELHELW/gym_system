import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

void displayQrFunction(String data) async {
  return await Get.dialog(
    Dialog(
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'QR Code',
              style: Theme.of(
                Get.context!,
              ).textTheme.headlineSmall!.copyWith(color: AppColors.dark),
            ),
          ),
          QrImageView(
            backgroundColor: Colors.white,
            version: QrVersions.auto,
            size: 200.0,
            embeddedImage: AssetImage('assets/images/logo.png'),
            embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
            data: data,
          ),

          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Developed By : Mahmoud Elhelw',
              style: Theme.of(Get.context!).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    ),
  );
}
