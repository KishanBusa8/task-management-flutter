import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:task_management/app/data/services/global/theme_controller.dart';
import 'package:task_management/app/modules/home/home_controller.dart';
import 'package:task_management/helpers/Utils/common_functions.dart';
import 'package:task_management/helpers/schema/color_schema.dart';

/// My App Bar
class MyAppBar extends StatefulWidget {
  MyAppBar({
    Key? key,
    required this.drawerKey,
  }) : super(key: key);
  GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _MyAppBarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isDrawerOpen = false;
  final HomeController _controller = Get.find();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// toggle for drawer and icon aniamtion
  void toggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        controller.forward();
        widget.drawerKey.currentState!.openSlider();
      } else {
        controller.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (logic) {
      return Container(
        color: ColorSchema().background(),
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Animated Icon - Menu & Close
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: controller,
                    size: 40,
                  ),
                  onPressed: toggle,
                ),
              ),

              /// Delete Icon
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    _controller.tasks.value.isEmpty
                        ? CommonFunctions().warningNoTask()
                        : CommonFunctions().deleteAllTask(onDelete: () {
                            _controller.deleteAllTask();
                          });
                  },
                  child: const Icon(
                    CupertinoIcons.trash,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
