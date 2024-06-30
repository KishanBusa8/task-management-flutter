import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/app/data/models/task_model.dart';
import 'package:task_management/app/modules/tasks/task_view.dart';
import 'package:task_management/helpers/Utils/common_functions.dart';
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  // ignore: library_private_types_in_public_api
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController taskControllerForTitle = TextEditingController();
  TextEditingController taskControllerForSubtitle = TextEditingController();
  @override
  void initState() {
    super.initState();
    taskControllerForTitle.text = widget.task.title ?? '';
    taskControllerForSubtitle.text = widget.task.description ?? '';
  }

  @override
  void dispose() {
    taskControllerForTitle.dispose();
    taskControllerForSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => TaskView(
              taskControllerForTitle: taskControllerForTitle,
              taskControllerForSubtitle: taskControllerForSubtitle,
              task: widget.task,
            ),
          ),
        );
      },

      /// Main Card
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: widget.task.status == TaskStatus.done.name
                ? const Color.fromARGB(154, 119, 144, 229)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10)
            ]),
        child: ListTile(

            /// Check icon
            leading: GestureDetector(
              onTap: () {
                // widget.task.status == TaskStatus.done.name = !widget.task.status == TaskStatus.done.name;
                // widget.task.save();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                    color: widget.task.status == TaskStatus.done.name
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
              child: Text(
                taskControllerForTitle.text,
                style: TextStyle(
                  color: widget.task.status == TaskStatus.done.name
                      ? SingleColor.primary
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration: widget.task.status == TaskStatus.done.name
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),

            /// Description of task
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskControllerForSubtitle.text,
                  style: TextStyle(
                    color: widget.task.status == TaskStatus.done.name
                        ? SingleColor.primary
                        : const Color.fromARGB(255, 164, 164, 164),
                    fontWeight: FontWeight.w300,
                    decoration: widget.task.status == TaskStatus.done.name
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
                        // Text(
                        //   DateFormat('hh:mm a')
                        //       .format(widget.task.createdAtTime),
                        //   style: TextStyle(
                        //       fontSize: 14,
                        //       color: widget.task.status == TaskStatus.done.name
                        //           ? Colors.white
                        //           : Colors.grey),
                        // ),
                        Text(
                          CommonFunctions.convertServerDateToString(
                              widget.task.createdAt ?? ''),
                          style: CustomTextStyle.body2().copyWith(
                            fontSize: 12,
                            color: widget.task.status == TaskStatus.done.name
                                ? ColorSchema.universalSwap()
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
