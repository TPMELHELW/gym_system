import 'package:flutter/material.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';

class NoramlButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const NoramlButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: AppColors.border,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
