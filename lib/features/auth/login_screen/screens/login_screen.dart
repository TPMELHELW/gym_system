import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/common/custom_text_field_widget.dart';
import 'package:gym_qr_code/core/common/noraml_button_widget.dart';
import 'package:gym_qr_code/core/validation/input_validation.dart';
import 'package:gym_qr_code/features/auth/login_screen/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 40.0),
            Form(
              key: controller.formState,
              child: Column(
                spacing: 10.0,
                children: [
                  CustomTextFieldWidget(
                    controller: controller.nameController,
                    hint: 'الاسم',
                    validator: (value) =>
                        AppFieldValidator.validateEmpty(value, 'الاسم'),
                  ),
                  CustomTextFieldWidget(
                    controller: controller.passwordController,
                    hint: 'كلمة المرور',
                    isPassword: true,
                    validator: (value) =>
                        AppFieldValidator.validateEmpty(value, 'كلمة المرور'),
                  ),
                  NormalButtonWidget(
                    text: 'تسجيل الدخول',
                    onPressed: () => controller.login(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
