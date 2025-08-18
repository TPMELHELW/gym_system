import 'package:flutter/material.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CalenderSelectionWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const CalenderSelectionWidget({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final QrCodesDataController homeController = QrCodesDataController.to;
    return Expanded(
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.grey,
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Icon(Iconsax.calendar),
        ),
        onTap: () => homeController.selectDate(context, controller),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please pick a date';
          }
          return null;
        },
      ),
    );
  }
}
