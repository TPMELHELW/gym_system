import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

showSelectImage() {
  final QrCodesDataController homeController = QrCodesDataController.to;
  return Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () async {
              await homeController.chooseImage(false);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.gallery, size: 50),
                Text(
                  'المعرض',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.copyWith(color: AppColors.dark),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: () async {
              await homeController.chooseImage(true);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.camera, size: 50),
                Text(
                  'الكاميرا',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.copyWith(color: AppColors.dark),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
