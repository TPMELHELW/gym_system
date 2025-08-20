import 'package:flutter/material.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final bool isPassword;
  const CustomTextFieldWidget({
    super.key,
    required this.hint,
    this.controller,
    required this.validator,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,

      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? Icon(Iconsax.password_check)
            : Icon(Iconsax.user),
        filled: true,
        fillColor: AppColors.grey,
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
