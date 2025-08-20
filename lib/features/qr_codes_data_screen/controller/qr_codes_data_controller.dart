// import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/enum/status_request.dart';
import 'package:gym_qr_code/core/functions/check_internet.dart';
import 'package:gym_qr_code/core/functions/show_snackbar.dart';
// import 'package:gym_qr_code/core/services/user_services.dart';
import 'package:gym_qr_code/data/user_repository.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/supescriber_model.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/display_qr_function.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

class QrCodesDataController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static QrCodesDataController get to => Get.find<QrCodesDataController>();
  // final UserServices userServices = UserServices();
  final TextEditingController firstDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  late TabController tabController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<String> imagePath = ''.obs;
  RxList<SupescriberModel> users = <SupescriberModel>[].obs;
  RxList<SupescriberModel> filteredUsers = <SupescriberModel>[].obs;
  final UserRepository userRepository = Get.find<UserRepository>();
  late Rx<StatusRequest> statusRequest;

  Rx<bool> isEdit = false.obs;
  int currentIndex = 0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final RxList<SupescriberModel> expiringUsers = <SupescriberModel>[].obs;

  void checkExpiringSubscriptions() {
    final now = DateTime.now();

    expiringUsers.value = users.where((user) {
      final diff = user.endDateAsDateTime.difference(now).inDays;
      return diff <= 3 && diff >= 0;
    }).toList();
  }

  void searchFun(String query) {
    if (query.isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      filteredUsers.assignAll(
        users.where(
          (user) => user.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  // Future<void> loadUsers() async {
  //   users.value = await userServices.getUsers();
  //   filteredUsers.assignAll(users);
  //   log('Loaded users: ${users.length}');
  // }

  Future<void> loadUsers() async {
    try {
      if (!await checkInternet()) return;
      users.value = await userRepository.getUsers();
      filteredUsers.assignAll(users);
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  // Future<void> deleteUser(int index) async {
  //   // Use filteredUsers for index
  //   final user = filteredUsers[index];
  //   final userIndex = users.indexOf(user);

  //   await userServices.deleteUserAt(userIndex);
  //   final File imageFile = File(user.imagePath);
  //   if (await imageFile.exists()) {
  //     await imageFile.delete();
  //   }
  //   users.removeAt(userIndex);
  //   filteredUsers.removeAt(index);
  // }
  Future<void> deleteUser(int index) async {
    try {
      if (!await checkInternet()) return;
      final user = filteredUsers[index];
      await userRepository.deleteUser(user.id);
      final File imageFile = File(user.imagePath);
      if (await imageFile.exists()) {
        await imageFile.delete();
      }
      users.remove(user);
      filteredUsers.removeAt(index);
      searchFun('');
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  void getInputToEdit(int index) {
    final user = filteredUsers[index];
    firstDateController.text = user.startDate;
    endDateController.text = user.endDate;
    nameController.text = user.name;
    imagePath.value = user.imagePath;
    currentIndex = users.indexOf(user);
    isEdit.value = true;
  }

  Future<void> editUser() async {
    if (!await checkInternet()) return;
    if (!formKey.currentState!.validate()) return;
    final user = SupescriberModel(
      name: nameController.text,
      startDate: firstDateController.text,
      endDate: endDateController.text,
      imagePath: imagePath.value,
      id: users[currentIndex].id,
    );
    await userRepository.saveUser(user);
    users[currentIndex] = user;
    searchFun('');
    isEdit.value = false;
    resetController();
  }

  void resetController() {
    nameController.clear();
    firstDateController.clear();
    endDateController.clear();
    imagePath.value = '';
  }

  // Future<void> addUser() async {
  //   if (!formKey.currentState!.validate()) return;
  //   log(imagePath.value);
  //   final user = SupescriberModel(
  //     name: nameController.text,
  //     startDate: firstDateController.text,
  //     endDate: endDateController.text,
  //     imagePath: imagePath.value == ''
  //         ? 'assets/images/logo2.jpg'
  //         : imagePath.value,
  //     id: DateTime.now().millisecondsSinceEpoch,
  //   );
  //   await userServices.addUser(user);
  //   await loadUsers();
  //   searchFun('');
  //   displayQrFunction(
  //     '${user.id}\n${user.name}\n${user.startDate}\n${user.endDate}',
  //   );
  //   resetController();
  // }

  Future<void> addUser() async {
    try {
      if (!await checkInternet()) return;
      if (!formKey.currentState!.validate()) return;
      final user = SupescriberModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text,
        startDate: firstDateController.text,
        endDate: endDateController.text,
        imagePath: imagePath.value == ''
            ? 'assets/images/logo2.jpg'
            : imagePath.value,
      );
      await userRepository.saveUser(user);
      users.add(user);
      filteredUsers.add(user);
      displayQrFunction(
        '${user.id}\n${user.name}\n${user.startDate}\n${user.endDate}',
      );
      resetController();
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
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

  // Future<void> clearSavedImages() async {
  //   final Directory appDir = await getApplicationDocumentsDirectory();
  //   final List<FileSystemEntity> files = appDir.listSync();
  //   for (final file in files) {
  //     if (file.path.endsWith('.jpg') || file.path.endsWith('.png')) {
  //       await file.delete();
  //     }
  //   }
  // }

  // Future<void> chooseImage(bool isCamera) async {
  //   try {
  //     final pickedFile = await ImagePicker().pickImage(
  //       source: isCamera ? ImageSource.camera : ImageSource.gallery,
  //     );
  //     if (pickedFile == null) {
  //       return;
  //     }
  //     CroppedFile? croppedFile = await ImageCropper().cropImage(
  //       sourcePath: pickedFile.path,
  //       uiSettings: [
  //         AndroidUiSettings(
  //           toolbarTitle: 'تعديل الصورة',
  //           cropStyle: CropStyle.circle,
  //           toolbarColor: Colors.blue,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false,
  //         ),
  //       ],
  //     );
  //     if (croppedFile == null) {
  //       // log('ddd');
  //       return;
  //     }
  //     // log('ssss');
  //     final Directory appPath = await getApplicationDocumentsDirectory();
  //     final String fileName = basename(croppedFile.path);
  //     final String destinationPath = path.join(appPath.path, fileName);
  //     final File newImage = await File(croppedFile.path).copy(destinationPath);

  //     imagePath.value = newImage.path;
  //     // log('Image saved at: $imagePath');
  //     Get.back();
  //   } catch (e) {
  //     log('Error choosing image: $e');
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    // _initNotifications();
    loadUsers().then((_) {
      filteredUsers.assignAll(users);
      // checkExpiredSubscriptions();
    });
    tabController = TabController(length: 2, vsync: this);
    statusRequest = StatusRequest.empty.obs;
  }

  void _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  void onClose() {
    super.onClose();
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
    final userServices = Get.put<UserRepository>(UserRepository());
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
