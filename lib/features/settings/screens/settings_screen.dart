import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpsons_app/core/preference/preference.dart';

import 'package:toggle_switch/toggle_switch.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ToggleSwitch(
              minWidth: 150,
              minHeight: 50,
              cornerRadius: 150,
              activeBgColors: [
                [Colors.green[800]!],
                [Colors.green[800]!]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: Preferences.isSpanish ? 0 : 1,
              // totalSwitches: 2,
              labels: Preferences.isSpanish
                  ? const ['Español', 'Inglés']
                  : const ['Spanish', 'Inglish'],
              radiusStyle: true,
              onToggle: (index) {
                if (index == 0) {
                  Preferences.isSpanish = true;
                  return;
                }

                if (index == 1) {
                  Preferences.isSpanish = false;
                  return;
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
            ToggleSwitch(
              minWidth: 90.0,
              minHeight: 70.0,
              initialLabelIndex: 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              icons: [
                FontAwesomeIcons.lightbulb,
                FontAwesomeIcons.solidLightbulb,
              ],
              iconSize: 30.0,
              activeBgColors: [
                [Colors.black45, Colors.black26],
                [Colors.yellow, Colors.orange]
              ],
              animationDuration: 100,
              animate:
                  true, // with just animate set to true, default curve = Curves.easeIn
              curve: Curves
                  .easeIn, // animate must be set to true when using custom curve
              onToggle: (index) {
                if (index == 0) {
                  Preferences.isLight = false;
                  return;
                }

                if (index == 1) {
                  Preferences.isLight = true;
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
