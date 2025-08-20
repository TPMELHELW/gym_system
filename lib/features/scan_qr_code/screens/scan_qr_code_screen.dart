import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/features/scan_qr_code/controller/scan_qr_code_controller.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanQrCodeController controller = Get.put(ScanQrCodeController());
    return Scaffold(
      appBar: AppBar(title: Text("QR Code Scanner")),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: controller.qrKey,
              onQRViewCreated: controller.onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: GetBuilder<ScanQrCodeController>(
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<ScanQrCodeController>(
                        builder: (controller) {
                          return CircleAvatar(
                            backgroundImage: controller.provider,
                            radius: 60,
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      Text(
                        controller.scannedData ?? "Scan a QR code",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.light,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
