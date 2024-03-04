import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/settings/pages/settings_view.dart';
import 'package:todo/features/tasks/pages/tasks_view.dart';

import 'core/config/constants/constants.dart';

class SettingsProvider extends ChangeNotifier {
  DateTime selectedTime = DateTime.now();
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = "en";
  List<Widget> navigationScreens = [TasksView(), SettingsView()];
  int currentItemIndex = 0;

  Future<SharedPreferences> getSharedPrefInstance() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> getLanguage() async {
    var sharedPref = await getSharedPrefInstance();
    currentLanguage = sharedPref.getString(LANGUAGE_KEY_PREF) ?? "en";
    notifyListeners();
  }

  Future<void> getThemeMode() async {
    var sharedPref = await getSharedPrefInstance();
    if (sharedPref.getString(THEME_KEY_PREF) != null) {
      currentTheme = sharedPref.getString(THEME_KEY_PREF) == LIGHT
          ? ThemeMode.light
          : ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.light;
    }
    notifyListeners();
  }

  setCurrentItemIndex(int index) {
    if (currentItemIndex == index)
      return;
    else {
      currentItemIndex = index;
    }
    notifyListeners();
  }

  Widget getCurrentScreen() => navigationScreens[currentItemIndex];

  Future<void> changeTheme(ThemeMode themeMode) async {
    if (themeMode == currentTheme) return;
    currentTheme = themeMode;
    var sharedPref = await getSharedPrefInstance();
    String value = themeMode == ThemeMode.light ? LIGHT : DARK;
    sharedPref.setString(THEME_KEY_PREF, value);
    notifyListeners();
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    var sharedPref = await getSharedPrefInstance();
    sharedPref.setString(LANGUAGE_KEY_PREF, newLanguage);
    notifyListeners();
  }

  bool isDark() => currentTheme == ThemeMode.dark;

  Future selectTime(BuildContext context) async {
    var currentSelectedTime = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (currentSelectedTime == null) return;
    selectedTime = currentSelectedTime;
    notifyListeners();
  }
}
