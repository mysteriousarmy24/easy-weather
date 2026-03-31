import 'package:easy_wheather/Services/theme_persistance.dart';
import 'package:easy_wheather/utilities/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeDataModes().lightTheme;
  final ThemePersistance _themePersistance = ThemePersistance();

//constructor
  ThemeProvider(){
    _loadThemeData();
  }

  //getter
  ThemeData get getThemeData => _themeData;

  //setter
  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  //load theme data
  Future<void> _loadThemeData() async {
    bool isDark = await _themePersistance.loadThemeData();
    setThemeData = isDark
        ? ThemeDataModes().darkTheme
        : ThemeDataModes().lightTheme;
  }
  //toggle theme
  Future <void> toggleTheme(bool isDark)async{
    setThemeData = isDark
        ? ThemeDataModes().darkTheme
        : ThemeDataModes().lightTheme;
        await _themePersistance.saveThemeData(isDark); 
        notifyListeners();
  } 
}
