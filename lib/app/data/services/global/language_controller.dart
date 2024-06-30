// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/helpers/constants/storage_constants.dart';

class LanguageController extends GetxController {
  final storage = GetStorage();
  final RxList<LanguageModel> languageList = <LanguageModel>[].obs;

  RxString language = "".obs;

  Future<dynamic> editLanguage(BuildContext context, String lang) async {
    // CustomDialogs.getInstance.showProgressDialog(context);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      StorageConstants().localePut(language.value);

      Get.updateLocale(Locale(language.value));
    });
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // fillLanguageData();
    languageList.addAll(LanguageModel.getThemeList);
    super.onInit();
  }

//   Future<void> fillLanguageData() async {
//     languageList.clear();
//     languageList.addAll(LanguageModel.getThemeList);
//     for (final element in languageList) {
//       if (storage.read(StorageConstants.locale) == null) {
//         if (element.code == Get.deviceLocale!.languageCode) {
//           element.isSelected.value = true;
//           await storage.write(
//             StorageConstants.localeName,
//             element.languageName,
//           );
//         }
//       }
//       if (storage.read(StorageConstants.locale) == element.code) {
//         element.isSelected.value = true;
//       }
//     }
//     update();
//   }

//   Future setLocale({required String code}) async {
//     if (code == 'system') {
//       storage.remove(StorageConstants.locale);
//       Get.updateLocale(const Locale('en')); // TODO: get system locale

//     } else {
//       await storage.write(StorageConstants.locale, code);
//       Get.updateLocale(Locale(code));
//     }
//     update();
//   }
}

class LanguageModel {
  LanguageModel({
    required this.languageName,
    required this.code,
  });

  String languageName;
  String code;
  RxBool isSelected = false.obs;

  static RxList<LanguageModel> getThemeList = <LanguageModel>[
    LanguageModel(
      languageName: "English",
      code: 'en',
    ),
    LanguageModel(
      languageName: "Portuguese",
      code: 'pt',
    ),
  ].obs;
}
