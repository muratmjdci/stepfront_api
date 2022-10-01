
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../routes.dart';



/// Consists common methods
abstract class Utils {
  const Utils._();

  /// shows pre-configured -> dialog, snackbar, bottomsheet, toast
  ///
  /// Utils.show.dialog(YourDialog());
  static const show = _Show();

  /// Bunch of ready to use validators for TextFields
  ///
  /// ```
  /// TextFormField(
  ///   validator: Utils.validators.email,
  /// );
  /// ```
  static const validators = _Validators();

  /// Unfocus the keyboard
  static void closeKeyboard(BuildContext c) {
    FocusScope.of(c).requestFocus(FocusNode());
  }

}

class _Validators {
  const _Validators();

  /// makes the textfield is required
  String? empty(String? value) {
    if (value == '' || value == null) {
      return 'Enter text';
    }
    return null;
  }

  String? minChar(String? value) {
    if (value!.isEmpty) {
      return 'Enter text';
    } else {
      if (value.length < 10) {
        return 'Min character is $value';
      }
    }
    return null;
  }

  String? minMaxChar(String? value) {
    if (value!.isEmpty) {
      return 'Enter text';
    } else {
      if (value.length < 5) {
        return 'Min character is $value';
      }
      if (value.length > 50) {
        return 'Max character is $value';
      }
    }
    return null;
  }


  String? password(String? value) {
    if (value!.isEmpty) {
      return 'Enter text';
    } else {
      if (value.length < 6) {
        return 'Min character is $value';
      }
    }
    return null;
  }

  String? email(String? value) {
    final isEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value!);
    if (value.isEmpty) {
      return 'Enter text';
    } else if (!isEmail) {
      return 'Invalid email';
    }
    return null;
  }

  /// validates the passwords match
  String? confirmPassword(String? value, String? newValue) {
    if (value != newValue) {
      return "Passwords doesn't match";
    }
    return null;
  }
}

// a global variable that tell is Dialog is open or not
bool isDialogOpen = false;

class _Show {
  const _Show();

  Future dialog(
    Widget child, {
    bool? isDismissible,
    BorderRadius? borderRadius,
    double? height,
    double? width,
    bool? hasBorder = true,
    int? count,
    bool showBackgroundColor = true,
  }) {
    isDialogOpen = true;
    return showDialog(
      barrierColor: !showBackgroundColor ? Colors.transparent : Colors.black54,
      context: Routes.context,
      builder: (_) => WillPopScope(
        onWillPop: () async => isDismissible ?? true,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: SizedBox(
              height: height,
              child: Material(
                color: hasBorder! ? null : Colors.transparent,
                borderRadius: borderRadius ?? BorderRadius.circular(16),
                child: child,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: isDismissible ?? true,
    ).then((_) => isDialogOpen = false);
  }

  void snackBar(
    String text, {
    TextStyle? titleStyle,
    TextStyle? textStyle,
    int? duration,
    Color? bgColor,
    Icon? icon,
    String? title,
    List<Widget>? actions,
    FlashPosition? position,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    bool? isDismissible,
  }) async {
    showFlash(
      context: Routes.context,
      duration: Duration(seconds: duration ?? 3),
      builder: (_, c) {
        return Flash.bar(
          barrierDismissible: isDismissible ?? true,
          controller: c,
          backgroundColor: bgColor ?? Colors.black87,
          position: position ?? FlashPosition.bottom,
          margin: margin ?? EdgeInsets.zero,
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: FlashBar(
            title: title == null
                ? Container()
                : Text(
                    title,
                    style: titleStyle ??
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                  ),
            content: Text(
              text,
              style: textStyle ??
                  const TextStyle(fontSize: 16, color: Colors.white),
            ),
            icon: icon,
            actions: actions,
          ),
        );
      },
    );
  }

  void toast(
    String text, {
    int? duration,
    Alignment? alignment,
    BorderRadius? borderRadius,
    Color? bgColor,
    TextStyle? textStyle,
    bool? isDismissible,
  }) {
    showFlash(
      context: Routes.context,
      duration: Duration(seconds: duration ?? 3),
      builder: (_, c) {
        return Flash(
          controller: c,
          barrierDismissible: isDismissible ?? false,
          alignment: alignment ?? const Alignment(0, 0.8),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          backgroundColor: bgColor ?? Colors.black87,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              text,
              style: textStyle ??
                  const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}