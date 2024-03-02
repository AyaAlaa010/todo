
import 'package:flutter/material.dart';
import 'package:todo/features/settings/pages/settings_view.dart';
import 'package:todo/features/tasks/pages/tasks_view.dart';

class SettingsProvider extends ChangeNotifier {
  DateTime selectedTime=DateTime.now();
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = "en";
  List<Widget> navigationScreens = [TasksView(), SettingsView()];
  int currentItemIndex = 0;

  setCurrentItemIndex(int index) {
    if (currentItemIndex == index)
      return;
    else {
      currentItemIndex = index;
    }
    notifyListeners();
  }

  Widget getCurrentScreen() => navigationScreens[currentItemIndex];

  changeTheme(ThemeMode themeMode) {
    if (themeMode == currentTheme) return;
    currentTheme = themeMode;
    notifyListeners();
  }

  changeLanguage(String newLanguage) {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    notifyListeners();
  }

  bool isDark() => currentTheme == ThemeMode.dark;


  Future selectTime (BuildContext context) async{

    var  currentSelectedTime=  await showDatePicker(context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add( const Duration(days: 365)));
    if(currentSelectedTime==null) return ;
     selectedTime=currentSelectedTime;
     notifyListeners();
  }
}
