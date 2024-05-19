import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import 'package:simpsons_app/features/bottom_navigation_bar/provider/bottom_navigation_bar_provider.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  static String routeName = 'bottomNavigationBarScreen';
  const BottomNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottonNavigationBarProviderRead =
        context.read<BottomNavigationBarProvider>();
    final bottonNavigationBarProviderWatch =
        context.watch<BottomNavigationBarProvider>();
    return Scaffold(
      body: bottonNavigationBarProviderWatch
          .screens[bottonNavigationBarProviderWatch.selectedIndexNavigationBar],
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          color: AppStyles.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppStyles.gray500Color,
              spreadRadius: 0.1,
              blurRadius: 0.1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => bottonNavigationBarProviderRead
                      .onSelectBottomNavigationBar(selectedIndex: 0),
                  child: _NavigationBarItem(
                    isSelected: bottonNavigationBarProviderWatch
                            .selectedIndexNavigationBar ==
                        0,
                    selectedIcon: Icons.people_alt,
                    unSelectedIcon: Icons.people_alt_outlined,
                    label: 'Home',
                    index: 0,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => bottonNavigationBarProviderRead
                      .onSelectBottomNavigationBar(selectedIndex: 1),
                  child: _NavigationBarItem(
                    isSelected: bottonNavigationBarProviderWatch
                            .selectedIndexNavigationBar ==
                        1,
                    selectedIcon: Icons.favorite,
                    unSelectedIcon: Icons.favorite_border,
                    label: 'Favoritos',
                    index: 1,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => bottonNavigationBarProviderRead
                      .onSelectBottomNavigationBar(selectedIndex: 2),
                  child: _NavigationBarItem(
                    isSelected: bottonNavigationBarProviderWatch
                            .selectedIndexNavigationBar ==
                        2,
                    selectedIcon: Icons.settings_applications,
                    unSelectedIcon: Icons.settings_applications_sharp,
                    label: 'Setting',
                    index: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  final IconData selectedIcon;
  final IconData unSelectedIcon;
  final bool isSelected;
  final String label;
  final int index;
  const _NavigationBarItem(
      {required this.selectedIcon,
      required this.unSelectedIcon,
      required this.isSelected,
      required this.label,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          curve: Curves.linear,
          duration: const Duration(milliseconds: 250),
          padding: isSelected
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 5)
              : const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected
                ? AppStyles.lightGreen500Color
                : AppStyles.whiteColor,
          ),
          child: Icon(
            isSelected ? selectedIcon : unSelectedIcon,
            color: isSelected ? AppStyles.whiteColor : AppStyles.gray500Color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppStyles.gray500Color,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontFamily: AppStyles.fontFamilyFranklin,
          ),
        ),
      ],
    );
  }
}
