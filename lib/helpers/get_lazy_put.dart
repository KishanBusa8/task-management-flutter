import 'package:get/get.dart';
import 'package:task_management/app/data/services/global/global_controller.dart';
import 'package:task_management/app/data/services/global/language_controller.dart';
import 'package:task_management/app/data/services/global/theme_controller.dart';

void init() {
  // global controllers
  Get.lazyPut(() => GlobalController());
  Get.lazyPut(() => ThemeController());
  Get.lazyPut(() => LanguageController(), fenix: true);
}
