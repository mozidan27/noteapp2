import 'package:flutter/material.dart';
import 'package:note2/theme/theme.dart';

class Themeprovider with ChangeNotifier {
  // initially , theme is ligh mode
  ThemeData _themeData = lighMode;
  // getter method to access the theme from other parts of the code
  ThemeData get themeData => _themeData;
  // getter method to check if the theme is dark or not
  bool get isDarkMode => _themeData == dartMode;
  // setter method to set the new theme

  set themeData(ThemeData themeData) {
    // set the theme to the themeData
    _themeData = themeData;
    // notify the listeners
    notifyListeners();
  }
  // method to toggle the theme

  void toggleTheme() {
    // if the theme is dark , then set the theme to light
    // else set the theme to dark
    if (_themeData == lighMode) {
      themeData = dartMode;
    } else {
      themeData = lighMode;
    }
  }
}
