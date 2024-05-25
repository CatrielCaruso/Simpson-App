import 'package:flutter/material.dart';

import 'package:simpsons_app/features/favorites/screens/favorites_screen.dart';
import 'package:simpsons_app/features/settings/screens/settings_screen.dart';
import 'package:simpsons_app/features/simpsons/screens/simpsons_list/simpsons_list_screen.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
  int selectedIndexNavigationBar = 0;
  List<Widget> screens = [
    const SimpsonListScreen(),
    const FavoritesScreen(),
    const SettingScreen()
  ];

  Widget selectedScreen = const SimpsonListScreen();

  void onSelectBottomNavigationBar({required int selectedIndex}) {
    selectedIndexNavigationBar = selectedIndex;
    selectedScreen = screens[selectedIndexNavigationBar];
    notifyListeners();
  }
}
