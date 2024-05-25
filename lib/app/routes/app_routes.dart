import 'package:flutter/material.dart';

import 'package:simpsons_app/features/simpsons/screens/simpsons_list/simpsons_list_screen.dart';
import 'package:simpsons_app/features/bottom_navigation_bar/screen/bottom_navigation_bar_screen.dart';

/// Routes map
class AppRoutes {
  static const initialRoute = 'bottomNavigationBarScreen';
  // static const initialRoute = 'simpsonListScreen';

  static final Map<String, Widget Function(BuildContext)> routes = {
    SimpsonListScreen.routeName: (_) => const SimpsonListScreen(),
    BottomNavigationBarScreen.routeName: (_) =>
        const BottomNavigationBarScreen()
  };
}
