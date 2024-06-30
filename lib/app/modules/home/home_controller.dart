import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/app/data/models/task_model.dart';
import 'package:task_management/app/data/services/apiService/api_services.dart';
import 'package:task_management/helpers/Utils/common_functions.dart';
import 'package:task_management/helpers/constants/api_constants.dart';

class HomeController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllTask();
    });
    super.onInit();
  }

  /// Checking Done Tasks
  int checkDoneTask() {
    int i = 0;
    for (Task doneTasks in tasks.value) {
      if (doneTasks.status == TaskStatus.done.name) {
        i++;
      }
    }
    return i;
  }

  /// Checking The Value Of the Circle Indicator
  dynamic valueOfTheIndicator() {
    if (tasks.isNotEmpty) {
      return tasks.length;
    } else {
      return 3;
    }
  }

  Future<void> getAllTask() async {
    CommonFunctions().showLoadingDialog();
    try {
      final Response response = await _apiService.makeApiCall(
        ApiConstants.todos,
        ApiMethodType.get,
      );
      Get.back();
      if (response.statusCode == 200) {
        tasks.value =
            (response.body as List).map((e) => Task.fromJson(e)).toList();
      }
    } catch (e) {
      CommonFunctions().showSnackBar(message: 'Something went wrong!');
    }
  }

  Future<void> deleteTaskById(String id) async {
    CommonFunctions().showLoadingDialog();
    try {
      final Response response = await _apiService.makeApiCall(
        '${ApiConstants.todos}/$id',
        ApiMethodType.delete,
      );
      Get.back();
      if (response.statusCode == 200) {
        tasks.value.removeWhere((e) => e.sId == id);
        CommonFunctions().showSnackBar(message: response.body['message']);
      } else {
        CommonFunctions().showSnackBar(
          message: response.body['error'],
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      CommonFunctions().showSnackBar(message: 'Something went wrong!');
    }
  }

  Future<void> createTask(Task task) async {
    CommonFunctions().showLoadingDialog();
    try {
      final Response response = await _apiService
          .makeApiCall(ApiConstants.todos, ApiMethodType.post, params: {
        'title': task.title,
        'description': task.description,
        'status': task.status,
        'dueDate': task.dueDate,
        'dueTime': task.dueTime,
      });
      Get.back();
      if (response.statusCode == 200) {
        CommonFunctions().showSnackBar(message: 'Task Added successfully');
        getAllTask();
      } else {
        CommonFunctions().showSnackBar(
          message: response.body['error'],
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      CommonFunctions().showSnackBar(message: 'Something went wrong!');
    }
  }

  Future<void> updateTaskById(String id, Task task) async {
    CommonFunctions().showLoadingDialog();
    try {
      final Response response = await _apiService
          .makeApiCall('${ApiConstants.todos}/$id', ApiMethodType.put, params: {
        'title': task.title,
        'description': task.description,
        'status': task.status,
        'dueDate': task.dueDate,
        'dueTime': task.dueTime,
      });
      Get.back();
      if (response.statusCode == 200) {
        CommonFunctions().showSnackBar(message: 'Task Updated successfully');
        getAllTask();
      } else {
        CommonFunctions().showSnackBar(
          message: response.body['error'],
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      CommonFunctions().showSnackBar(message: 'Something went wrong!');
    }
  }
}
