// Dart imports:

// Package imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/app/data/models/user_model.dart';
import 'package:task_management/app/data/services/apiService/api_services.dart';
import 'package:task_management/helpers/constants/api_constants.dart';
import 'package:task_management/helpers/constants/storage_constants.dart';

class GlobalController extends GetxService {
  final ApiService _apiService = ApiService();

  final GetStorage storage = GetStorage();
  final RxBool noNetwork = false.obs;
  final RxBool isAuthenticated = false.obs;
  final Rx<User> user = User().obs;
  Rx<TextEditingController> marginController = TextEditingController().obs;
  final RxBool marginUpdateLoading = false.obs;

  @override
  void onInit() {
    user.value = getUser();
    if (user.value.sId != null) {
      getUserFromApi();
    }
    super.onInit();
  }

  User getUser() {
    if (GetStorage().read(StorageConstants.user) != null) {
      return User.fromJson(
          jsonDecode(GetStorage().read(StorageConstants.user)));
    } else {
      return User();
    }
  }

  Future<void> getUserFromApi() async {
    final Response response = await _apiService.makeApiCall(
      ApiConstants.getUser,
      ApiMethodType.get,
    );
    if (response.statusCode == 200) {
      user.value = User.fromJson(response.body['user']);
      await GetStorage()
          .write(StorageConstants.user, jsonEncode(user.toJson()));
    }
  }
}
