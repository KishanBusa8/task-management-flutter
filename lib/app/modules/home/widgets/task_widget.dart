import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/app/data/models/task_model.dart';
import 'package:task_management/app/modules/home/home_controller.dart';
import 'package:task_management/app/modules/tasks/task_view.dart';
import 'package:task_management/helpers/Utils/common_functions.dart';
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({Key? key, required this.task, required this.index})
      : super(key: key);
  final Rx<Task> task;
  final int index;
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => TaskView(
              taskControllerForTitle:
                  TextEditingController(text: task.value.title ?? ''),
              taskControllerForSubtitle:
                  TextEditingController(text: task.value.description ?? ''),
              task: task.value,
            ),
          ),
        );
      },

      /// Main Card
      child: Obx(() {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: task.value.status == TaskStatus.done.name
                ? const Color.fromARGB(154, 119, 144, 229)
                : task.value.status == TaskStatus.inProgress.name
                    ? Colors.pinkAccent.shade100
                    : ColorSchema().boxModal(),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                offset: const Offset(0, 5),
                blurRadius: 10,
              )
            ],
          ),
          child: ListTile(

              /// Check icon
              leading: GestureDetector(
                onTap: () {
                  if (task.value.status == TaskStatus.done.name) {
                    task.value.status = TaskStatus.todo.name;
                  } else {
                    task.value.status = TaskStatus.done.name;
                  }
                  _controller.tasks.value[index].status = task.value.status;
                  _controller.updateTaskById(
                    _controller.tasks.value[index].sId!,
                    _controller.tasks.value[index],
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  decoration: BoxDecoration(
                      color: task.value.status == TaskStatus.done.name
                          ? SingleColor.primary
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: .8)),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),

              /// title of Task
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.value.title ?? '',
                        style: TextStyle(
                          color: task.value.status == TaskStatus.done.name
                              ? SingleColor.primary
                              : ColorSchema().universalSwap(),
                          fontWeight: FontWeight.w500,
                          decoration: task.value.status == TaskStatus.done.name
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    Text(
                      (task.value.status ?? '').capitalizeFirst ?? '',
                      style: TextStyle(
                        color: task.value.status == TaskStatus.done.name
                            ? SingleColor.primary
                            : ColorSchema().universalSwap(),
                        fontWeight: FontWeight.w500,
                        decoration: task.value.status == TaskStatus.done.name
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ],
                ),
              ),

              /// Description of task
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.value.description ?? '',
                    style: TextStyle(
                      color: task.value.status == TaskStatus.done.name
                          ? SingleColor.primary
                          : task.value.status == TaskStatus.inProgress.name
                              ? Colors.white
                              : const Color.fromARGB(255, 164, 164, 164),
                      fontWeight: FontWeight.w300,
                      decoration: task.value.status == TaskStatus.done.name
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  /// Date & Time of Task
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            task.value.dueTime ?? '',
                            style: TextStyle(
                                fontSize: 14,
                                color: task.value.status == TaskStatus.done.name
                                    ? Colors.white
                                    : task.value.status ==
                                            TaskStatus.inProgress.name
                                        ? Colors.white
                                        : Colors.grey),
                          ),
                          Text(
                            CommonFunctions.convertServerDateToString(
                                task.value.dueDate ?? ''),
                            style: CustomTextStyle.body2().copyWith(
                              fontSize: 12,
                              color: task.value.status == TaskStatus.done.name
                                  ? Colors.white
                                  : task.value.status ==
                                          TaskStatus.inProgress.name
                                      ? Colors.white
                                      : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        );
      }),
    );
  }
}
