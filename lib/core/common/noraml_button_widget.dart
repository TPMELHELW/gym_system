import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/core/enum/status_request.dart';
import 'package:lottie/lottie.dart';

class NormalButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Rx<StatusRequest> statusRequest;
  NormalButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    Rx<StatusRequest>? statusRequest,
  }) : statusRequest = statusRequest ?? StatusRequest.empty.obs;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: AppColors.border,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: onPressed,
      child: Obx(() {
        if (statusRequest.value == StatusRequest.loading) {
          return Lottie.asset('assets/animation/loading.json', height: 50);
        }
        return Text(text);
      }),
    );
  }
}
