import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/services/user_services.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/user_model.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/display_qr_function.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class QrCodesDataController extends GetxController {
  static QrCodesDataController get to => Get.find<QrCodesDataController>();
  final UserServices userServices = UserServices();
  final TextEditingController firstDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String imagePath = '';

  RxList<UserModel> users = <UserModel>[].obs;
  Rx<bool> isEdit = false.obs;
  int currentIndex = 0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> loadUsers() async {
    users.value = await userServices.getUsers();
    log(users[0].imagePath);
  }

  Future<void> deleteUser(int index) async {
    await userServices.deleteUserAt(index);
    users.removeAt(index);
  }

  void getInputToEdit(int index) {
    firstDateController.text = users[index].startDate;
    endDateController.text = users[index].endDate;
    nameController.text = users[index].name;
    imagePath = users[index].imagePath;
    currentIndex = index;
    isEdit.value = true;
  }

  Future<void> editUser() async {
    final user = UserModel(
      name: nameController.text,
      startDate: firstDateController.text,
      endDate: endDateController.text,
      imagePath: imagePath,
    );
    await userServices.updateUserAt(currentIndex, user);
    users[currentIndex] = user;
    isEdit.value = false;
    resetController();
  }

  void resetController() {
    nameController.clear();
    firstDateController.clear();
    endDateController.clear();
    imagePath = '';
  }

  Future<void> addUser() async {
    if (!formKey.currentState!.validate()) return;
    log(imagePath);
    final user = UserModel(
      name: nameController.text,
      startDate: firstDateController.text,
      endDate: endDateController.text,
      imagePath: imagePath == '' ? 'assets/images/logo.png' : imagePath,
    );
    await userServices.addUser(user);
    await loadUsers();
    displayQrFunction('${user.name}\n${user.startDate}\n${user.endDate}');
    resetController();
  }

  Future<void> selectDate(
    // BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? picked = await showDatePicker(
      locale: Locale('ar', 'EG'),
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2070),
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
    }
  }

  Future<void> clearSavedImages() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = appDir.listSync();
    for (final file in files) {
      if (file.path.endsWith('.jpg') || file.path.endsWith('.png')) {
        await file.delete();
      }
    }
  }

  Future<void> chooseImage(bool isCamera) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedFile == null) {
        return;
      }
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'تعديل الصورة',
            cropStyle: CropStyle.circle,
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
      );
      if (croppedFile == null) {
        log('ddd');
        return;
      }
      log('ssss');
      final Directory appPath = await getApplicationDocumentsDirectory();
      final String fileName = basename(croppedFile.path);
      final String destinationPath = path.join(appPath.path, fileName);
      final File newImage = await File(croppedFile.path).copy(destinationPath);

      imagePath = newImage.path;
      log('Image saved at: $imagePath');
      Get.back();
    } catch (e) {
      log('Error choosing image: $e');
    }
  }

  @override
  void onInit() {
    _initNotifications();
    loadUsers().then((_) => checkExpiredSubscriptions());
    super.onInit();
  }

  void _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void checkExpiredSubscriptions() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    for (var user in users) {
      if (user.endDate == today) {
        showNotification(user.name, users.indexOf(user));
      }
    }
  }

  Future<void> showNotification(String userName, int notificationIndex) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'subscription_channel',
          'Subscription Notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      notificationIndex,
      'Subscription Ended',
      'تم انتهاء اشتراك $userName اليوم.',
      platformChannelSpecifics,
    );
  }

  static Future<void> sendExpiredNotifications() async {
    final userServices = UserServices();
    final users = await userServices.getUsers();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    for (var user in users) {
      if (user.endDate == today) {
        const androidDetails = AndroidNotificationDetails(
          'subscription_channel',
          'Subscription Notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        );
        const platformDetails = NotificationDetails(android: androidDetails);
        await flutterLocalNotificationsPlugin.show(
          users.indexOf(user),
          'Subscription Ended',
          'تم انتهاء اشتراك ${user.name} اليوم.',
          platformDetails,
        );
      }
    }
  }
}
