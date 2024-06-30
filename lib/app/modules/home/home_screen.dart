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
          child: _buildBody(),
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
                Obx(() {
                  return SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      valueColor:
                          const AlwaysStoppedAnimation(SingleColor.primary),
                      backgroundColor: Colors.grey,
                      value: _controller.checkDoneTask() /
                          _controller.valueOfTheIndicator(),
                    ),
                  );
                }),
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
                    Obx(() {
                      return Text(
                        "${_controller.checkDoneTask()} of ${_controller.tasks.length} task",
                        style: CustomTextStyle.heading(),
                      );
                    }),
                  ],
                ),
                const Spacer(),

                /// Filter option to filter task by status
                Obx(() {
                  return DropdownButton<String>(
                    value: _controller.selectedFilter.value,
                    items: <String>['All', 'ToDo', 'InProgress', 'Done']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (s) {
                      _controller.selectedFilter.value = s ?? '';
                      _controller.filterTask();
                    },
                  );
                }),
                const SizedBox(
                  width: 20,
                ),
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
              height: MediaQuery.of(Get.context!).size.height / 1.5,
              child: _controller.tasks.value.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                              Text(
                                MyString.deletedTask,
                                style: CustomTextStyle.body2().copyWith(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                          onDismissed: (direction) {},
                          key: Key(task.sId ?? ''),
                          child: TaskWidget(
                            task: task.obs,
                            index: index,
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
