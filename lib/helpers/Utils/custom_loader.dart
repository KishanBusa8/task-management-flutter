// ignore_for_file: prefer_constructors_over_static_methods

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/helpers/schema/color_schema.dart';

class CustomDialogs {
  static CustomDialogs? _shared;

  CustomDialogs._();

  static CustomDialogs get getInstance =>
      _shared = _shared ?? CustomDialogs._();

  void showProgressDialog() {
    showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CupertinoActivityIndicator(
                    radius: 22,
                    color: SingleColor.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void hideProgressDialog() {
    Navigator.pop(Get.context!);
  }
}
