import 'package:flutter/material.dart';

import 'package:simpsons_app/core/theme/app_styles.dart';

class AppTheme {
  ThemeData getLightTheme() => ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        appBarTheme: const AppBarTheme(color: Colors.yellow),
        primaryColor: Colors.yellow,
      );
  ThemeData getDarkTheme() => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        appBarTheme: const AppBarTheme(color: AppStyles.lightGreenColor),
        primaryColor: AppStyles.lightGreenColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppStyles.lightGreenColor),
      );
}
