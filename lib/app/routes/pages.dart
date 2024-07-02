// Package imports:
// Project imports:
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/app/modules/auth/signIn/sign_in_screen.dart';
import 'package:task_management/app/modules/auth/sign_up/sign_up.dart';
import 'package:task_management/app/modules/home/home_screen.dart';
import 'package:task_management/app/modules/splash/splash_screen.dart';
import 'package:task_management/helpers/constants/storage_constants.dart';

part 'routes.dart';

class AppPages {
  final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: Routes.initial,
      page: () => const SplashScreen(),
    ),
    GetPage<dynamic>(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      middlewares: [EnsureAuthSeller()],
    ),
    GetPage<dynamic>(
      name: Routes.signUp,
      page: () => SignUp(),
    ),
    GetPage<dynamic>(
      name: Routes.signIn,
      page: () => SignIn(),
    ),
  ];
}

class EnsureAuthSeller extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return GetStorage().read(StorageConstants.token) != null
        ? null
        : const RouteSettings(name: Routes.signIn);
  }
}
