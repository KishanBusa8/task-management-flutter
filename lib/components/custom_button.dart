import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

enum ButtonType { enable, disable, progress, outline }

class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  final double height;
  final double width;
  final String title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? onTap;
  final Color? titleColor;
  final Color? backgroundColor;
  final Border? border;
  final TextStyle? textStyle;
  final double radius;

  const CustomButton({
    Key? key,
    this.buttonType = ButtonType.disable,
    this.onTap,
    this.prefixIcon,
    this.backgroundColor,
    this.titleColor,
    this.textStyle,
    this.width = double.infinity,
    this.title = "",
    this.border,
    this.height = 50,
    this.suffixIcon,
    this.radius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color background = backgroundColor ?? SingleColor.primary;
    Color textColor = titleColor ?? Colors.grey.withOpacity(0.5);
    if (backgroundColor == null) {
      switch (buttonType) {
        case ButtonType.enable:
          {
            background = SingleColor.primary;

            textColor = titleColor ?? Colors.white;
          }
          break;
        case ButtonType.disable:
          {
            background = ColorSchema().lightGray();
            textColor = titleColor ?? Colors.grey.withOpacity(0.5);
          }
          break;
        case ButtonType.outline:
          {
            background = ColorSchema().background();
            textColor = titleColor ?? Colors.white;
          }
          break;
        case ButtonType.progress:
          {
            background = ColorSchema().lightGray();
          }
          break;
      }
    }
    return GestureDetector(
      onTap: () {
        if (buttonType == ButtonType.enable ||
            buttonType == ButtonType.outline) {
          if (onTap != null) {
            HapticFeedback.mediumImpact();
            onTap!();
          }
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: height,
            width: width,
            decoration: _getDecoration(background),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (buttonType == ButtonType.progress)
                  Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 25,
                    child: const CircularProgressIndicator(),
                  ),
                if (prefixIcon != null) prefixIcon ?? Container(),
                if (prefixIcon != null)
                  const SizedBox(
                    width: 10,
                  ),
                if (buttonType != ButtonType.progress)
                  Text(
                    title,
                    style: textStyle ??
                        CustomTextStyle.button().copyWith(
                          color: textColor,
                        ),
                  ),
                if (suffixIcon != null) suffixIcon ?? Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration(Color background) {
    if (buttonType == ButtonType.outline) {
      return BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          radius,
        ),
        border: border ?? Border.all(color: Colors.grey.withOpacity(0.7)),
      );
    }
    return BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(
        radius,
      ),
      // boxShadow: [
      //   BoxShadow(
      //     offset: const Offset(0, 8),
      //     blurRadius: 24,
      //     spreadRadius: -4,
      //     color: Colors.black.withOpacity(0.08),
      //   ),
      //   BoxShadow(
      //     offset: const Offset(0, 6),
      //     blurRadius: 12,
      //     spreadRadius: -6,
      //     color: Colors.black.withOpacity(0.08),
      //   ),
      // ],
    );
  }
}
