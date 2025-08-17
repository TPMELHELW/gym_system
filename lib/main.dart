import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/theme/theme.dart';
import 'package:gym_qr_code/features/home_screen/screens/home_screen.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/model/user_model.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
