import 'package:flutter/material.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/early_end_subsc_tab.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/main_home_tab.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class QrCodesDataScreen extends StatelessWidget {
  const QrCodesDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QrCodesDataController controller = QrCodesDataController.to;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        // width: 100,
        decoration: BoxDecoration(
          color: AppColors.light,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(icon: Icon(Iconsax.home, color: AppColors.dark)),
            Tab(icon: Icon(Iconsax.timer_1, color: AppColors.dark)),
          ],
        ),
      ),
      appBar: AppBar(title: Text('QR Codes Data')),
      body: TabBarView(
        controller: controller.tabController,
        children: [MainHomeTab(), EarlyEndSubscTab()],
      ),
    );
  }
}
