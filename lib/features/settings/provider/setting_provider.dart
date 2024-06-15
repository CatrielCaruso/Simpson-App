import 'package:flutter/material.dart';
import 'package:simpsons_app/core/preference/preference.dart';

class SettingProvider extends ChangeNotifier {
  SettingProvider() {
    isLight = Preferences.isLight;
  }

  bool _isLight = true;
  bool _isSpanish = true;

  bool get isSpanish => _isSpanish;
  bool get isLight => _isLight;

  set isSpanish(bool value) {
    _isSpanish = value;
    Preferences.isSpanish = value;
    notifyListeners();
  }

  set isLight(bool value) {
    _isLight = value;
    Preferences.isLight = value;
    notifyListeners();
  }
}
