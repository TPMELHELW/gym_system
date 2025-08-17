import 'package:flutter/material.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/core/theme/widget_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.light,
      titleTextStyle: TTextTheme.lightTextTheme.headlineMedium,
      iconTheme: IconThemeData(color: AppColors.dark),
    ),
    scaffoldBackgroundColor: AppColors.light,

    textTheme: TTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark,
      titleTextStyle: TTextTheme.darkTextTheme.headlineMedium,
      iconTheme: IconThemeData(color: AppColors.light),
    ),
    scaffoldBackgroundColor: AppColors.dark,
    useMaterial3: true,
    textTheme: TTextTheme.darkTextTheme,
  );
}
