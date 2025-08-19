import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/display_qr_function.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';

class SubscribersWidget extends StatelessWidget {
  const SubscribersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final QrCodesDataController controller = QrCodesDataController.to;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(() {
        if (controller.users.isEmpty) {
          return Center(
            child: Lottie.asset('assets/animation/loading.json', height: 50),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.filteredUsers.length,
          itemBuilder: (context, index) {
            final user = controller.filteredUsers[index];
            ImageProvider? provider;

            if (user.imagePath.isNotEmpty) {
              if (user.imagePath.startsWith('assets/')) {
                provider = AssetImage(user.imagePath);
              } else {
                provider = FileImage(File(user.imagePath));
              }
            }

            return ListTile(
              onTap: () {
                displayQrFunction(
                  '${user.id}\n${user.name}\n${user.startDate}\n${user.endDate}',
                );
              },
              leading: CircleAvatar(backgroundImage: provider),
              title: Text(
                user.name,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.dark),
              ),
              subtitle: Text(
                'Start Date: ${user.startDate}\nEnd Date: ${user.endDate}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Iconsax.edit),
                    onPressed: () => controller.getInputToEdit(index),
                  ),
                  IconButton(
                    icon: Icon(Iconsax.trash),
                    onPressed: () => controller.deleteUser(index),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
