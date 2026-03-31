import 'package:shared_preferences/shared_preferences.dart';

class ThemePersistance {
  //save data to shared preferences
  Future<void> saveThemeData(bool isDark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isDark", isDark);
    print("Done");
  }

  //load from preferences
  Future<bool> loadThemeData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("loaded");
    return preferences.getBool("isDark") ?? false;
  }
}
