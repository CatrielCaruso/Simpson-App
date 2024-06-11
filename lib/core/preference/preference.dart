import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  // ignore: unused_field
  static bool _spanish = true;

  static bool _isLight = true;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isSpanish {
    return _prefs.getBool('spanish') ?? _spanish;
  }

  static set isSpanish(bool value) {
    _spanish = value;
    _prefs.setBool('spanish', value);
  }

  static bool get isLight {
    return _prefs.getBool('isLight') ?? _isLight;
  }

  static set isLight(bool value) {
    _isLight = value;
    _prefs.setBool('isLight', value);
  }
}
