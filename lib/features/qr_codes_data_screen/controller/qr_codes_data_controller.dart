import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/services/user_services.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class QrCodesDataController extends GetxController {
  static QrCodesDataController get to => Get.find<QrCodesDataController>();
  final UserServices userServices = UserServices();
  final TextEditingController firstDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  RxList<UserModel> users = <UserModel>[].obs;
  Rx<bool> isEdit = false.obs;
  int currentIndex = 0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
    isEdit.value = false;
    resetController();
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
    await loadUsers();
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
