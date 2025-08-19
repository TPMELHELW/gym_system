import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

SnackbarController showErrorSnackbar(String text) {
  return Get.snackbar(
    'Error',
    text,
    backgroundColor: Colors.red,
    icon: const Icon(Iconsax.close_circle, color: Colors.black),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
  );
}

SnackbarController showSuccessSnackbar(String text) {
  return Get.snackbar(
    'Success',
    text,
    backgroundColor: Colors.blue,
    icon: const Icon(Iconsax.copy_success),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
  );
}
