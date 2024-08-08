import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:simpsons_app/core/theme/app_styles.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final Color? colorText;
  final Color? colorBg;
  final dynamic borderSide;
  final double elevation;
  final VoidCallback submitFunction;
  final double height;
  final Widget? icon;
  final bool loading;
  final bool disabled;
  final TextStyle? textStyle;
  final bool? isSecondaryButton; // outline button

  /// boton amarillo relleno
  /// recibe como parametro un título [title] y si se desea cambiar el color de texto [colorText]
  /// para cambiar el fondo del boton [colorBg] y si se desea un borden [borderSide]
  /// y una función [submitFunction] que se ejecuta en el click
  const CustomButtonWidget(
      {Key? key,
      required this.title,
      required this.submitFunction,
      this.colorText = AppStyles.green900Color,
      this.colorBg = AppStyles.lightGreen500Color,
      this.borderSide,
      this.elevation = 0,
      this.height = 48,
      this.icon,
      this.loading = false,
      this.disabled = false,
      this.textStyle =
          const TextStyle(fontSize: 16, height: 1, fontWeight: FontWeight.w600),
      this.isSecondaryButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: icon != null
          ? ElevatedButton.icon(
              icon: icon!,
              onPressed: disabled
                  ? null
                  : loading // si hay un laoding en curso que no mande la funcion
                      ? () {}
                      : submitFunction,
              label: Text(title),
              style: ElevatedButton.styleFrom(
                foregroundColor: colorText,
                backgroundColor: colorBg,
                shape: borderSide != null
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                        side: borderSide,
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48)),
                shadowColor: Colors.transparent,
                textStyle: textStyle,
                elevation: elevation,
              ).copyWith(
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed))

                    // ignore: curly_braces_in_flow_control_structures
                    return (isSecondaryButton!)
                        ? AppStyles.lightGreen20Color
                        : AppStyles.lightGreen500Color;
                  return null;
                }),
                shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled))
                    // ignore: curly_braces_in_flow_control_structures
                    return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48));
                  return borderSide != null
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(48),
                          side: borderSide,
                        )
                      : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(48));
                }),
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled))
                    // ignore: curly_braces_in_flow_control_structures
                    return isSecondaryButton!
                        ? AppStyles.whiteColor
                        : AppStyles.gray200Color;
                  return colorBg; // Defer to the widget's default.
                }),
                foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled))
                    // ignore: curly_braces_in_flow_control_structures
                    return isSecondaryButton!
                        ? AppStyles.gray600Color
                        : AppStyles.gray600Color;
                  return colorText; // Defer to the widget's default.
                }),
              ),
            )
          : ElevatedButton(
              onPressed: disabled
                  ? null
                  : loading // si hay un laoding en curso que no mande la funcion
                      ? () {}
                      : submitFunction,
              style: ElevatedButton.styleFrom(
                foregroundColor: colorText,
                backgroundColor: colorBg,
                shape: borderSide != null
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                        side: borderSide,
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                shadowColor: Colors.transparent,
                textStyle: const TextStyle(
                    fontSize: 16, height: 1, fontWeight: FontWeight.w600),
                elevation: elevation,

                //onSurface: CustomStylesTheme.gray200Color.withOpacity(0.12),
              ).copyWith(
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed))
                    // ignore: curly_braces_in_flow_control_structures
                    return (isSecondaryButton!)
                        ? AppStyles.lightGreen20Color
                        : AppStyles.lightGreen500Color;
                  return null;
                }),
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled))
                    // ignore: curly_braces_in_flow_control_structures
                    return isSecondaryButton!
                        ? AppStyles.whiteColor
                        : AppStyles.gray200Color;
                  return colorBg; // Defer to the widget's default.
                }),
                foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled))
                    // ignore: curly_braces_in_flow_control_structures
                    return isSecondaryButton!
                        ? AppStyles.gray600Color
                        : AppStyles.gray700Color;
                  return colorText; // Defer to the widget's default.
                }),
              ),
              child: loading
                  ? SpinKitThreeBounce(
                      color: colorText,
                      size: 30.0,
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        color: (disabled) ? AppStyles.gray700Color : colorText,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
    );
  }
}
