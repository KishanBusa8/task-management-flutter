import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/app/data/models/user_model.dart';
import 'package:task_management/app/data/services/apiService/api_services.dart';
import 'package:task_management/app/data/services/global/global_controller.dart';
import 'package:task_management/app/routes/pages.dart';
import 'package:task_management/components/custom_button.dart';
import 'package:task_management/helpers/Utils/common_functions.dart';
import 'package:task_management/helpers/constants/api_constants.dart';
import 'package:task_management/helpers/constants/storage_constants.dart';

class SignInController extends GetxController {
  final ApiService _apiService = ApiService();
  final GlobalController _globalController = Get.find();
  Rx<TextEditingController> emailTextController = TextEditingController().obs;
  Rx<TextEditingController> passwordTextController =
      TextEditingController().obs;

  RxBool passwordVisible = false.obs;
  RxBool loading = false.obs;

  ButtonType getButtonType() {
    if (loading.value) {
      return ButtonType.progress;
    } else if (emailTextController.value.text.isEmpty ||
        !emailTextController.value.text.isEmail ||
        passwordTextController.value.text.isEmpty ||
        passwordTextController.value.text.length < 6) {
      return ButtonType.disable;
    } else {
      return ButtonType.enable;
    }
  }

  Future<void> login() async {
    loading.value = true;
    final Response response = await _apiService.makeApiCall(
      ApiConstants.signIn,
      ApiMethodType.post,
      params: {
        "email": emailTextController.value.text,
        "password": passwordTextController.value.text,
      },
    );
    loading.value = false;
    if (response.statusCode == 200) {
      _globalController.user.value = User.fromJson(response.body['user']);
      await GetStorage().write(StorageConstants.token, response.body['token']);
      await GetStorage().write(
        StorageConstants.user,
        jsonEncode(_globalController.user.toJson()),
      );

      Get.offAllNamed(Routes.homeScreen);
    } else {
      CommonFunctions().showSnackBar(
        message: 'Invalid email or password',
        backgroundColor: Colors.red,
      );
    }
  }
}
