import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_management/app/data/services/global/theme_controller.dart';
import 'package:task_management/helpers/schema/color_schema.dart';

class BaseWidget extends StatelessWidget {
  BaseWidget({super.key, required this.body});
  Widget body;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (logic) {
      return Scaffold(
        backgroundColor: ColorSchema().background(),
        body: body,
      );
    });
  }
}
