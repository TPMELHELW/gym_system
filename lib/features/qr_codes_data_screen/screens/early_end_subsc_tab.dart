import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/early_end_controller.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/subscribers_widget.dart';

class EarlyEndSubscTab extends StatelessWidget {
  const EarlyEndSubscTab({super.key});

  @override
  Widget build(BuildContext context) {
    final EarlyEndController controller = Get.put(EarlyEndController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        spacing: 20,
        children: [
          Text(
            controller.expiringUsers.isEmpty
                ? 'لا توجد اشتراكات تنتهي قريبا'
                : 'المشتركين الذين تنتهي اشتراكاتهم قريبا:',
          ),

          controller.expiringUsers.isEmpty
              ? SizedBox()
              : SubscribersWidget(users: controller.expiringUsers),
        ],
      ),
    );
  }
}
