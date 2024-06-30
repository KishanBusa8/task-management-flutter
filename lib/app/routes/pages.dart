// Package imports:
// Project imports:
import 'package:get/get.dart';
import 'package:task_management/app/modules/home/home_screen.dart';
import 'package:task_management/app/modules/splash/splash_screen.dart';

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
    ),
  ];
}
