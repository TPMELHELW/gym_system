import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/features/info/controller/info_controller.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Info Screen'), centerTitle: true),
      body: Center(
        child: GetBuilder<InfoController>(
          init: InfoController(),
          builder: (controller) {
            return AnimatedOpacity(
              opacity: controller.isFade ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Developed By [Mahmoud Elhelw] 🤍 \n mahmoudtarekelhelw1234@gmail.com \n +201026271039 \n Version 1.0.0 \n © 2025 All rights reserved.',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
