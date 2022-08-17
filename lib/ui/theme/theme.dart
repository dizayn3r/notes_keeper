import 'package:flutter/material.dart';
import 'package:notes_keeper/ui/theme/config.dart';

class MyTheme with ChangeNotifier {
  static bool isDark = false;
  MyTheme() {
    if (box.containsKey('currentTheme')) {
      isDark = box.get('currentTheme');
    } else {
      box.put('currentTheme', isDark);
    }
  }

  ThemeMode currentTheme() => isDark ? ThemeMode.dark : ThemeMode.light;

  void switchTheme(){
    isDark = !isDark;
    box.put('currentTheme', isDark);
    notifyListeners();
  }
}
