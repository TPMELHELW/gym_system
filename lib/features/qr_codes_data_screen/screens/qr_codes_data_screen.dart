import 'package:flutter/material.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/form_qr_widget.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/subscribers_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
              TextFormField(
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.dark),
                // controller: controller.searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.light,
                  hintText: 'البحث عن مشترك',
                  suffixIcon: Icon(Iconsax.search_normal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: controller.searchFun,
              ),
              SubscribersWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
