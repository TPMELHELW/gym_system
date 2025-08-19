import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/common/noraml_button_widget.dart';
import 'package:gym_qr_code/core/routes/app_routes.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الشاشة الرئيسية'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.toNamed(AppRoutes.info),
          icon: Icon(Iconsax.info_circle_copy),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/logo1.png'),
            SizedBox(height: 30),
            NoramlButtonWidget(
              onPressed: () {
                Get.toNamed(AppRoutes.qrData);
              },
              text: 'إدارة المشتركين',
            ),
            NoramlButtonWidget(
              onPressed: () {
                Get.toNamed(AppRoutes.scan);
              },
              text: 'مسح رمز الاستجابة السريعة',
            ),
          ],
        ),
      ),
    );
  }
}
