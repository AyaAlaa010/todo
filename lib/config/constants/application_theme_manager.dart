import 'package:flutter/material.dart';

import 'app_colors.dart';

class ApplicationThmeManager {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.onPrimaryColor,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            fontFamily: "Poppins",
            color: Colors.white),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          fontFamily: "Poppins",
          color: AppColors.primaryColor,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          fontFamily: "Poppins",
          color: AppColors.primaryColor,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          fontFamily: "Poppins",
          color: AppColors.primaryColor,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          fontFamily: "Poppins",
          color: AppColors.primaryColor,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.transparent,
          selectedIconTheme:
              IconThemeData(color: AppColors.primaryColor, size: 38),
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 30)),
      bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white, padding: EdgeInsetsDirectional.all(0)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(color: Colors.white, width: 4)),
        elevation: 3,
      ));

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.onPrimaryDarkColor,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            fontFamily: "Poppins",
            color: AppColors.primaryColor),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          fontFamily: "Poppins",
          color: AppColors.onPrimaryDarkColor,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          fontFamily: "Poppins",
          color: AppColors.gray,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: "Poppins",
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.transparent,
          selectedIconTheme:
              IconThemeData(color: AppColors.primaryColor, size: 38),
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 30)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(color: AppColors.nav_color, width: 4)),
        elevation: 3,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColors.nav_color, padding: EdgeInsetsDirectional.all(0)));
}
