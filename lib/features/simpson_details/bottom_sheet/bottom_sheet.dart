import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:simpsons_app/core/theme/app_styles.dart';
import 'package:simpsons_app/features/settings/provider/setting_provider.dart';

class BottomMenuTheme {
  static void showMenu(
      {required BuildContext context,
      required Widget content,
      Color? barrierColor,
      bool isScrollControlled = true,
      double? height,
      bool autoHeight = false,
      bool isDismissible = true,
      bool enableDrag = true,
      bool scrolKeyboard = true // para empujar el contenido hacia arriba
      }) {
    showModalBottomSheet(
        context: context,
        // constraints: BoxConstraints(
        //     maxHeight: deviceSize.height,
        //     minHeight: 300,
        //     maxWidth: double.infinity,
        //     minWidth: double.infinity),
        // isDismissible: false,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        isScrollControlled: isScrollControlled,
        backgroundColor: AppStyles.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        barrierColor: barrierColor ?? AppStyles.overlayColor.withOpacity(0.3),
        builder: (builder) {
          return BottomModal(
              content: content,
              height: height,
              autoHeight: autoHeight,
              scrolKeyboard: scrolKeyboard);
        });
  }
}

class BottomModal extends StatelessWidget {
  final Widget content;
  final double? height; // altura del buttom sheet
  final bool autoHeight;
  final bool scrolKeyboard;

  /// Widget para el contenido del modal
  const BottomModal({
    Key? key,
    required this.content,
    this.height,
    this.autoHeight = false,
    required this.scrolKeyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProviderWatch = context.watch<SettingProvider>();
    // final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: scrolKeyboard
          ? EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              // top: MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
              //     .padding
              //     .top,
            )
          : null,
      child: Container(
        //height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: settingProviderWatch.isLight
              ? AppStyles.whiteColor
              : AppStyles.lightGreen500Color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: SafeArea(
          child: Wrap(
            children: [
              Align(
                child: Container(
                  width: 48,
                  height: 5,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppStyles.baseColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              autoHeight
                  ? content
                  : SizedBox(
                      height:
                          height ?? MediaQuery.of(context).size.height * 0.85,
                      child: content,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
