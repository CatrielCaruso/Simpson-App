import 'package:flutter/material.dart';
import 'package:simpsons_app/core/theme/app_styles.dart';
import 'package:simpsons_app/features/simpson_details/widgets/custom_button_widget.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String title;
  final Color colorBorder;
  final Color? colorText;
  final VoidCallback submitFunction;
  final Widget? icon;
  final bool disabled;
  final double elevation;
  final double height;
  final TextStyle? textStyle;
  final Color? colorBg;
  const OutlineButtonWidget({
    Key? key,
    required this.title,
    this.colorBorder = AppStyles.lightGreenColor,
    required this.submitFunction,
    this.colorText = AppStyles.green900Color,
    this.icon,
    this.disabled = false,
    this.elevation = 0,
    this.height = 48.0,
    this.textStyle =
        const TextStyle(fontSize: 16, height: 1, fontWeight: FontWeight.w600),
    this.colorBg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButtonWidget(
      isSecondaryButton: true,
      textStyle: textStyle,
      title: title,
      borderSide: BorderSide(
        width: 2,
        color: disabled ? AppStyles.gray200Color : colorBorder,
      ),
      colorBg: colorBg,
      colorText: disabled ? AppStyles.gray600Color : colorText,
      icon: icon,
      disabled: disabled,
      elevation: elevation,
      submitFunction: submitFunction,
    );
  }
}
