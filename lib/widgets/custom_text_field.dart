import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../core/styles.dart';

class CustomTextField extends HookWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final Icon? prefixIcon;
  final TextInputType? textInputType;
  final String? initialValue;
  final bool readOnly;
  const CustomTextField( 
      {Key? key,
      this.readOnly = false,
      this.textInputType,
      this.hintText,
      required this.controller,
      this.isPassword = false,
      this.validator,
      this.textInputAction,
      this.initialValue,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showPassword = useState(isPassword);
    return TextFormField(
      readOnly: readOnly,
      autofocus: false,
      autocorrect: false,
      textInputAction: textInputAction,
      validator: validator,
      initialValue: initialValue,
      obscureText: showPassword.value,
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: S.colors.blue.withOpacity(.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: readOnly ? S.colors.blue.withOpacity(.5) : S.colors.blue,
          ),
        ),
        label: Text(hintText ?? ''),
        labelStyle: TextStyle(fontSize: 14, color: S.colors.text),
        prefixIcon: prefixIcon,
        suffixIcon: isPassword
            ? IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  !showPassword.value
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                ),
                onPressed: () {
                  showPassword.value = !showPassword.value;
                },
              )
            : null,
      ),
    );
  }
}
