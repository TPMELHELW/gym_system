import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/services/user_services.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/user_model.dart';
import 'package:intl/intl.dart';

class QrCodesDataController extends GetxController {
  static QrCodesDataController get to => Get.find<QrCodesDataController>();
  final UserServices userServices = UserServices();
  final TextEditingController firstDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  RxList<UserModel> users = <UserModel>[].obs;
  Rx<bool> isEdit = false.obs;
  int currentIndex = 0;

  Future<void> loadUsers() async {
    users.value = await userServices.getUsers();
  }

  Future<void> deleteUser(int index) async {
    await userServices.deleteUserAt(index);
    users.removeAt(index);
  }

  void getInputToEdit(int index) {
    firstDateController.text = users[index].startDate;
    endDateController.text = users[index].endDate;
    nameController.text = users[index].name;
    currentIndex = index;
    isEdit.value = true;
  }

  Future<void> editUser() async {
    final user = UserModel(
      name: nameController.text,
      startDate: firstDateController.text,
      endDate: endDateController.text,
    );
    await userServices.updateUserAt(currentIndex, user);
    users[currentIndex] = user;
    resetController();
    isEdit.value = false;
  }

  void resetController() {
    nameController.clear();
    firstDateController.clear();
    endDateController.clear();
  }

  Future<void> addUser() async {
    final user = UserModel(
      name: nameController.text,
      startDate: firstDateController.text,
      endDate: endDateController.text,
    );
    await userServices.addUser(user);
    loadUsers();
    resetController();
  }

  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      // initialDatePickerMode :DatePickerMode.
      lastDate: DateTime(2070),
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
    }
  }

  @override
  void onInit() {
    loadUsers();
    super.onInit();
  }
}
