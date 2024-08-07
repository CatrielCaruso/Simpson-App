import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpsons_app/core/theme/app_styles.dart';
import 'package:simpsons_app/features/settings/provider/setting_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingProvider readSettingProvider = context.read<SettingProvider>();
    SettingProvider watchSettingProvider = context.watch<SettingProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              watchSettingProvider.isSpanish
                  ? 'Cambiar idioma:'
                  : 'Change language',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ToggleSwitch(
                minWidth: 150,
                minHeight: 50,
                cornerRadius: 150,

                activeBgColors: const [
                  [AppStyles.lightGreen500Color],
                  [AppStyles.lightGreen500Color]
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                initialLabelIndex: readSettingProvider.isSpanish ? 0 : 1,
                // totalSwitches: 2,
                labels: watchSettingProvider.isSpanish
                    ? const ['Español', 'Inglés']
                    : const ['Spanish', 'Inglish'],
                radiusStyle: true,
                onToggle: (index) {
                  if (index == 0) {
                    readSettingProvider.isSpanish = true;
                    return;
                  }

                  if (index == 1) {
                    readSettingProvider.isSpanish = false;
                    return;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              watchSettingProvider.isSpanish
                  ? watchSettingProvider.isLight
                      ? 'Tema: Normal'
                      : 'Tema: Halloween'
                  : watchSettingProvider.isLight
                      ? 'Theme: Normal'
                      : 'Theme: Halloween',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ToggleSwitch(
                minWidth: 90.0,
                minHeight: 70.0,
                initialLabelIndex: readSettingProvider.isLight ? 1 : 0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                icons: const [
                  FontAwesomeIcons.lightbulb,
                  FontAwesomeIcons.solidLightbulb,
                ],
                iconSize: 30.0,
                activeBgColors: const [
                  [Colors.black45, Colors.black],
                  [Colors.yellow, Colors.orange]
                ],
                animationDuration: 100,
                animate:
                    true, // with just animate set to true, default curve = Curves.easeIn
                curve: Curves
                    .easeIn, // animate must be set to true when using custom curve
                onToggle: (index) {
                  if (index == 0) {
                    readSettingProvider.isLight = false;
                    return;
                  }

                  if (index == 1) {
                    readSettingProvider.isLight = true;
                    return;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
