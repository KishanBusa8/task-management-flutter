import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management/app/modules/home/home_controller.dart';
import 'package:task_management/app/modules/home/widgets/add_button.dart';
import 'package:task_management/app/modules/home/widgets/app_bar.dart';
import 'package:task_management/app/modules/home/widgets/slider_drawer.dart';
import 'package:task_management/app/modules/home/widgets/task_widget.dart';
import 'package:task_management/helpers/Utils/string.dart';
import 'package:task_management/helpers/constants/image_constants.dart';
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey<SliderDrawerState> dKey = GlobalKey<SliderDrawerState>();
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.background(),
      floatingActionButton: const FAB(),
      body: SliderDrawer(
        isDraggable: false,
        key: dKey,
        animationDuration: 1000,

        /// My AppBar
        appBar: MyAppBar(
          drawerKey: dKey,
        ),

        /// My Drawer Slider
        slider: MySlider(),

        /// Main Body
        child: SafeArea(
          child: Container(),
        ),
      ),
    );
  }

  /// Main Body
  SizedBox _buildBody() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          /// Top Section Of Home page : Text, Progrss Indicator
          Container(
            margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),
            width: double.infinity,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// CircularProgressIndicator
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    valueColor:
                        const AlwaysStoppedAnimation(SingleColor.primary),
                    backgroundColor: Colors.grey,
                    value: _controller.checkDoneTask() /
                        _controller.valueOfTheIndicator(),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),

                /// Texts
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MyString.mainTitle,
                      style: CustomTextStyle.title(),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${_controller.checkDoneTask()} of ${_controller.tasks.length} task",
                      style: CustomTextStyle.heading(),
                    ),
                  ],
                )
              ],
            ),
          ),

          /// Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          /// Bottom ListView : Tasks
          Obx(() {
            return SizedBox(
              width: double.infinity,
              height: 585,
              child: _controller.tasks.value.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _controller.tasks.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        var task = _controller.tasks.value[index];

                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(MyString.deletedTask,
                                  style: CustomTextStyle.body2().copyWith(
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                          onDismissed: (direction) {},
                          key: Key(task.sId ?? ''),
                          child: TaskWidget(
                            task: _controller.tasks.value[index],
                          ),
                        );
                      },
                    )

                  /// if All Tasks Done Show this Widgets
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Lottie
                        FadeIn(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              ImageConstants.lottieUrl,
                              animate: _controller.tasks.value.isNotEmpty
                                  ? false
                                  : true,
                            ),
                          ),
                        ),

                        /// Bottom Texts
                        FadeInUp(
                          from: 30,
                          child: const Text(MyString.doneAllTask),
                        ),
                      ],
                    ),
            );
          })
        ],
      ),
    );
  }
}
