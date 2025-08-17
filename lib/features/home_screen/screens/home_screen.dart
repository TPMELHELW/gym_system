import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/common/noraml_button_widget.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/qr_codes_data_screen.dart';
import 'package:gym_qr_code/features/scan_qr_code/screens/scan_qr_code_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 30),
            NoramlButtonWidget(
              onPressed: () {
                Get.to(() => QrCodesDataScreen());
              },
              text: 'Add New QR Code',
            ),
            NoramlButtonWidget(
              onPressed: () {
                Get.to(ScanQrCodeScreen());
              },
              text: 'Scan Qr Code',
            ),
          ],
        ),
      ),
    );
  }
}
