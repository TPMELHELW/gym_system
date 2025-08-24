import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/enum/status_request.dart';
import 'package:gym_qr_code/core/functions/check_internet.dart';
import 'package:gym_qr_code/core/functions/show_snackbar.dart';
import 'package:gym_qr_code/core/services/user_services.dart';
import 'package:gym_qr_code/data/auth_repository.dart';
import 'package:gym_qr_code/data/user_repository.dart';
import 'package:gym_qr_code/features/auth/model/user_model.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();
  late TextEditingController nameController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> formState = GlobalKey();
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();
  final UserServices _userServices = UserServices();
  late Rx<StatusRequest> statusRequest;

  Future<void> login() async {
    try {
      if (!await checkInternet()) {
        statusRequest.value = StatusRequest.offline;
        return;
      }

      if (!formState.currentState!.validate()) return;
      statusRequest.value = StatusRequest.loading;
      await _authRepository.signInWithEmail(
        nameController.text,
        passwordController.text,
      );

      final UserModel user = await _userRepository.fetchSpesificUser(
        _authRepository.currentUser!.uid,
      );

      await _userServices.addUser(user);
      statusRequest.value = StatusRequest.success;
      Get.offAllNamed("/home");
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  @override
  void onInit() {
    statusRequest = StatusRequest.empty.obs;
    nameController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}
