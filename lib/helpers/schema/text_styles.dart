import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/helpers/constants/storage_constants.dart';
import 'package:task_management/helpers/schema/color_schema.dart';

enum FontFamily { Poppins, JosefinSans }

class CustomTextStyle {
  static GetStorage storage = GetStorage();

  static bool isDarkTheme() {
    if (storage.read(StorageConstants.customBrightness) == "light") {
      return false;
    } else if (storage.read(StorageConstants.customBrightness) == "dark") {
      return true;
    } else {
      return MediaQuery.of(Get.context!).platformBrightness == Brightness.dark;
    }
  }

  static TextStyle title() {
    return ThemeTextStyles().title.copyWith(color: ColorSchema.universalSwap());
  }

  static TextStyle small() {
    return ThemeTextStyles().small.copyWith(color: ColorSchema.universalSwap());
  }

  static TextStyle appbar() {
    return ThemeTextStyles()
        .appbar
        .copyWith(color: ColorSchema.universalSwap());
  }

  static TextStyle heading() {
    return ThemeTextStyles()
        .heading
        .copyWith(color: ColorSchema.universalSwap());
  }

  static TextStyle subHeading() {
    return ThemeTextStyles()
        .subHeading
        .copyWith(color: ColorSchema.universalSwap());
  }

  static TextStyle button() {
    return ThemeTextStyles()
        .button
        .copyWith(color: ColorSchema.universalSwap());
  }

  static TextStyle textFiled() {
    return ThemeTextStyles()
        .textField
        .copyWith(color: ColorSchema.universalSwap());
  }

  static TextStyle body2() {
    return ThemeTextStyles().body2.copyWith(color: ColorSchema.universalSwap());
  }

  static TextStyle heading2() {
    return ThemeTextStyles()
        .heading2
        .copyWith(color: ColorSchema.universalSwap());
  }
}

class ThemeTextStyles {
  TextStyle small = const TextStyle(
    fontSize: CustomFontSize.small,
    fontWeight: FontWeight.w500,
    color: SingleColor.white,
  );
  TextStyle appbar = const TextStyle(
    fontSize: CustomFontSize.heading,
    fontWeight: FontWeight.w500,
    color: SingleColor.white,
    letterSpacing: 1,
  );
  TextStyle heading = const TextStyle(
    fontSize: CustomFontSize.heading,
    fontWeight: FontWeight.w500,
    color: SingleColor.primary,
  );
  TextStyle subHeading = const TextStyle(
    fontSize: CustomFontSize.heading,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  TextStyle button = const TextStyle(
    fontSize: CustomFontSize.body2,
    fontWeight: FontWeight.w600,
    color: SingleColor.white,
  );

  TextStyle textField = const TextStyle(
    fontSize: CustomFontSize.body,
    fontWeight: FontWeight.w500,
    color: SingleColor.darkGray,
  );

  TextStyle body2 = const TextStyle(
    fontSize: CustomFontSize.body2,
    fontWeight: FontWeight.w400,
    color: SingleColor.primary,
  );
  TextStyle heading2 = const TextStyle(
    fontSize: CustomFontSize.heading2,
    fontWeight: FontWeight.w600,
    color: SingleColor.white,
  );
  TextStyle title = TextStyle(
    fontSize: CustomFontSize.title,
    fontWeight: FontWeight.normal,
    color: SingleColor.white,
    fontFamily: FontFamily.JosefinSans.name,
  );
  TextStyle subtitle = const TextStyle(
    fontSize: CustomFontSize.subtitle,
    fontWeight: FontWeight.w500,
    color: SingleColor.midGray3,
  );
  TextStyle splash = TextStyle(
    fontSize: CustomFontSize.splash,
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontFamily: FontFamily.JosefinSans.name,
  );
}

class CustomFontSize {
  static const double splash = 34;
  static const double title = 27;
  static const double heading2 = 30;
  static const double heading = 20;
  static const double body2 = 16;
  static const double body = 14;
  static const double subtitle = 12;
  static const double small = 11;
}
