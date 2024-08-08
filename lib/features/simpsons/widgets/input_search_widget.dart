import 'package:flutter/material.dart';
import 'package:simpsons_app/core/theme/app_styles.dart';

/// La función [onSearch] tiene que poder recibir un string en su argumento.
class InputSearchWidget extends StatefulWidget {
  const InputSearchWidget({
    Key? key,
    this.label,
    this.hint,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.title,
    this.searchIcon = false,
    this.widthText = 100,
    this.onSearch,
    this.onTapOutside,
    this.focusNode,
    this.constroller,
  }) : super(key: key);
  final String? label;
  final String? hint;
  final FocusNode? focusNode;
  final String? errorMessage;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextInputType? keyboardType;
  final String? title;
  final bool searchIcon;
  final double? widthText;
  final Function? onSearch;
  final TextEditingController? constroller;

  @override
  State<InputSearchWidget> createState() => _InputSearchWidgetState();
}

class _InputSearchWidgetState extends State<InputSearchWidget> {
  // late TextEditingController editingController= TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   // editingController.text = widget.constroller!.text;
  // }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   widget.constroller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return TextFormField(
      style: const TextStyle(
          fontSize: 13,
          fontFamily: AppStyles.fontFamilyFranklin,
          fontWeight: FontWeight.w500,
          color: AppStyles.hintColor),
      focusNode: widget.focusNode,
      onTapOutside: widget.onTapOutside,
      keyboardType: widget.keyboardType,
      controller: widget.constroller!,
      onChanged: (_) {
        if (widget.onSearch == null) return;
        widget.onSearch!(widget.constroller!.text);
      },
      validator: widget.validator,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        suffixIcon: (widget.constroller!.text != '')
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  /* Clear the search field */
                  widget.constroller!.clear();
                  widget.onSearch!(widget.constroller!.text);
                },
              )
            : null,
        prefixIcon: Image.asset(
          'assets/img/ic_search.png',
        ),
        contentPadding: const EdgeInsets.only(left: 0),
        floatingLabelStyle: const TextStyle(color: AppStyles.blackColor),
        hintText: widget.hint,
        hintStyle: const TextStyle(
            fontSize: 13,
            fontFamily: AppStyles.fontFamilyFranklin,
            fontWeight: FontWeight.w500,
            color: AppStyles.hintColor),
        isDense: true,
        label: (widget.label != null) ? Text(widget.label!) : null,
        fillColor: Colors.white,
        filled: true,
        errorText: widget.errorMessage,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        focusedErrorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
      ),
    );
  }
}
