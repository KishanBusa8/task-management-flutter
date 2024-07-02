import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/app/data/services/global/global_controller.dart';
import 'package:task_management/app/data/services/global/theme_controller.dart';
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

/// My Drawer Slider
class MySlider extends StatelessWidget {
  MySlider({
    Key? key,
  }) : super(key: key);

  final GlobalController _globalController = Get.find();
  final ThemeController _themeController = Get.find();

  /// Icons
  List<IconData> icons = [];

  /// Texts
  List<String> texts = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SingleColor.primary,
            SingleColor.primary2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Obx(() {
            return Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  _themeController.toggleTheme();
                },
                icon: _themeController.isDarkMode.value
                    ? const Icon(Icons.light_mode)
                    : const Icon(
                        Icons.dark_mode,
                      ),
              ),
            );
          }),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/img/1.png'),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(_globalController.user.value.name ?? "AmirHossein Bayat",
              style: CustomTextStyle.heading()),
          Text(_globalController.user.value.email ?? "junior flutter dev",
              style: CustomTextStyle.heading()),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 10,
            ),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
                itemCount: icons.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return InkWell(
                    // ignore: avoid_print
                    onTap: () => print("$i Selected"),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        leading: Icon(
                          icons[i],
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          texts[i],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
