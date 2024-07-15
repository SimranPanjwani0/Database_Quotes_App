import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const String theme = 'theme';

  setTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(theme, value);
  }

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool(theme);
  }
}
