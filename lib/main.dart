import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/routes/app_pages.dart';
import 'package:gym_qr_code/core/theme/theme.dart';
import 'package:gym_qr_code/features/home_screen/screens/home_screen.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/user_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await QrCodesDataController.sendExpiredNotifications();
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.request();
  await Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    "1",
    "checkExpiredSubscriptions",
    frequency: Duration(hours: 24),
  );
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QrCodesDataController());
    return GetMaterialApp(
      getPages: AppPages().pages,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
