import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/display_qr_function.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/form_qr_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';

class QrCodesDataScreen extends StatelessWidget {
  const QrCodesDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QrCodesDataController controller = QrCodesDataController.to;
    return Scaffold(
      appBar: AppBar(title: Text('QR Codes Data')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  spacing: 20.0,
                  children: [
                    Text(
                      'إدارة بيانات رموز الاستجابة السريعة',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(color: AppColors.dark),
                    ),
                    FormQrWidget(),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Obx(() {
                  if (controller.users.isEmpty) {
                    return Center(
                      child: Lottie.asset(
                        'assets/animation/loading.json',
                        height: 50,
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final user = controller.users[index];
                      return ListTile(
                        onTap: () {
                          displayQrFunction(
                            '${controller.users[index].name}\n${controller.users[index].startDate}\n${controller.users[index].endDate}',
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/logo.png'),
                        ),
                        title: Text(
                          user.name,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppColors.dark),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
