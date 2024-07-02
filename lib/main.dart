import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/app/data/services/global/global_controller.dart';
import 'package:task_management/app/data/services/global/theme_controller.dart';
import 'package:task_management/app/modules/splash/splash_screen.dart';
import 'package:task_management/app/routes/pages.dart';
import 'package:task_management/helpers/Translation/translation.dart';
import 'package:task_management/helpers/constants/storage_constants.dart';
import 'package:task_management/helpers/get_lazy_put.dart' as lazy_put;
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  lazy_put.init();

  Get.put(GlobalController());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final GetStorage storage = GetStorage();
  final List<LocalizationsDelegate<dynamic>> localizationsDelegate =
      <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (controller) => GetMaterialApp(
        fallbackLocale: const Locale('en'),
        translations: Localization(),
        title: 'Task Management',
        locale: StorageConstants().localizationLocalOrDevice(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        themeMode: storage.read(StorageConstants.isDarkMode) ?? false
            ? ThemeMode.dark
            : ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        getPages: AppPages().pages,
      ),
    );
  }
}

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkTheme.background,
  appBarTheme: AppBarTheme(
    titleTextStyle: ThemeTextStyles().title.copyWith(
          color: Colors.white,
          fontSize: 23,
        ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30.0),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: DarkTheme.background),
);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: LightTheme.white,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    titleTextStyle:
        ThemeTextStyles().title.copyWith(color: Colors.white, fontSize: 23),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30.0),
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: LightTheme.white,
  ),
);
