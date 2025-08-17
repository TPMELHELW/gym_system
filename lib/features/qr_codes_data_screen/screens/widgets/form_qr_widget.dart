import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/calender_selection_widget.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/display_qr_function.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/core/common/noraml_button_widget.dart';

class FormQrWidget extends StatelessWidget {
  const FormQrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final QrCodesDataController homeController = QrCodesDataController.to;
    return Form(
      child: Column(
        spacing: 20,

        children: [
          TextFormField(
            controller: homeController.nameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.grey,
              hintText: 'Enter Name',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Row(
            spacing: 10,
            children: [
              CalenderSelectionWidget(
                label: 'Start Date',
                controller: homeController.firstDateController,
              ),
              CalenderSelectionWidget(
                label: 'End Date',
                controller: homeController.endDateController,
              ),
            ],
          ),
          Obx(
            () => NoramlButtonWidget(
              onPressed: () async {
                if (homeController.isEdit.value) {
                  await homeController.editUser();
                } else {
                  await homeController.addUser();
                  displayQrFunction(
                    '${homeController.nameController.text} \n${homeController.firstDateController.text} \n${homeController.endDateController.text}',
                  );
                }
              },
              text: homeController.isEdit.value
                  ? 'Update QR Code'
                  : 'Display QR Code',
            ),
          ),
        ],
      ),
    );
  }
}
