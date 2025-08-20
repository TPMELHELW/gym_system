import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/functions/init_services.dart';
import 'package:gym_qr_code/core/routes/app_pages.dart';
import 'package:gym_qr_code/core/theme/theme.dart';
import 'package:gym_qr_code/features/home_screen/screens/home_screen.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/user_model.dart';
import 'package:gym_qr_code/firebase_options.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
// await Hive.initFlutter();
// Hive.registerAdapter(UserModelAdapter());
//     await QrCodesDataController.sendExpiredNotifications();
//     return Future.value(true);
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initServices();
  // await Permission.notification.request();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  // await Workmanager().initialize(callbackDispatcher);
  // await Workmanager().registerPeriodicTask(
  //   DateTime.now().millisecondsSinceEpoch.toString(),
  //   "checkExpiredSubscriptions",
  //   frequency: const Duration(hours: 24),
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QrCodesDataController());
    return GetMaterialApp(
      locale: const Locale('ar', 'EG'),
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      fallbackLocale: const Locale('en', 'US'),

      getPages: AppPages().pages,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
