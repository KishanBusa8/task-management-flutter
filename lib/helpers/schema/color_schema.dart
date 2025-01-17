// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task_management/app/data/services/global/theme_controller.dart';

class ColorSchema {
  final ThemeController _themeController = Get.find();
  bool isDarkTheme() {
    return _themeController.isDarkMode.value;
  }

  Brightness keyboard() {
    return isDarkTheme() ? Brightness.dark : Brightness.light;
  }

  SystemUiOverlayStyle statusBar() {
    return isDarkTheme()
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
  }

  Color primary() {
    return isDarkTheme() ? DarkTheme.primary : LightTheme.primary;
  }

  Color background() {
    return isDarkTheme() ? DarkTheme.background : LightTheme.background;
  }

  Color universalSwap() {
    return !isDarkTheme() ? DarkTheme.background : LightTheme.background;
  }

  Color midGray3() {
    return !isDarkTheme() ? DarkTheme.midGray3 : LightTheme.midGray3;
  }

  Color midGray2() {
    return !isDarkTheme() ? DarkTheme.midGray2 : LightTheme.midGray2;
  }

  Color midGray1() {
    return !isDarkTheme() ? DarkTheme.midGray1 : LightTheme.midGray1;
  }

  Color darkGray() {
    return !isDarkTheme() ? DarkTheme.darkGray : LightTheme.darkGray;
  }

  Color lightGray() {
    return !isDarkTheme() ? DarkTheme.lightGray : LightTheme.lightGray;
  }

  Color boxModal() {
    return isDarkTheme() ? DarkTheme.ultraDarkGray : LightTheme.boxModal;
  }
}

class SingleColor {
  static const Color background = Color(0xff1F1F1F);
  static const Color colorRed = Color(0xffEE5253);
  static const Color white = Color(0xffFFFFFF);
  static const Color underLightGray = Color(0xffF2F2F2);
  static const Color lightGray = Color(0xffE6E6E6);
  static const Color midGray1 = Color(0xffDADADA);
  static const Color midGray2 = Color(0xffC2C2C2);
  static const Color midGray3 = Color(0xff919191);
  static const Color darkGray = Color(0xff747474);
  static const Color ultraDarkGray = Color(0xff1F1F1F);
  static const Color primary = Color(0xff4568dc);
  static const Color primary2 = Color(0xffb06ab3);
}

class LightTheme {
  // static const Color background = Color(0xFFfef1ee);
  static const Color background = Color(0xFFffffff);
  static const Color white = Color(0xffFFFFFF);
  static const Color underLightGray = Color(0xffF2F2F2);
  static const Color lightGray = Color(0xffE6E6E6);
  static const Color midGray1 = Color(0xffDADADA);
  static const Color midGray2 = Color(0xffC2C2C2);
  static const Color midGray3 = Color(0xff9B9B9B);
  static const Color darkGray = Color(0xff747474);
  static const Color ultraDarkGray = Color(0xff1F1F1F);
  static const Color primary = Color(0xff4568dc);
  static const Color primary2 = Color(0xffb06ab3);
  static const boxModal = Color(0xFFf7f6fd);
}

class DarkTheme {
  static const Color background = Colors.black;
  static const Color white = Color(0xffFFFFFF);
  static const Color underLightGray = Color(0xffF2F2F2);
  static const Color lightGray = Color(0xffE6E6E6);
  static const Color midGray1 = Color(0xffDADADA);
  static const Color midGray2 = Color(0xffC2C2C2);
  static const Color midGray3 = Color(0xff9B9B9B);
  static const Color darkGray = Color(0xff747474);
  static const Color ultraDarkGray = Color(0xff1F1F1F);
  static const Color primary = Color(0xff4568dc);
  static const Color primary2 = Color(0xffb06ab3);
  static const Color boxModal = Color(0xff20204a);
}
