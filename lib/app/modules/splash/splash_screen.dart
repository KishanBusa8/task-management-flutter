import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management/app/routes/pages.dart';
import 'package:task_management/components/base_widget.dart';
import 'package:task_management/helpers/constants/image_constants.dart';
import 'package:task_management/helpers/constants/storage_constants.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //if Subscription then add below Function.
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      checkUserLogin();
    });
  }

  Future<void> checkUserLogin() async {
    if (GetStorage().read(StorageConstants.token) != null) {
      Get.offAllNamed(
        Routes.homeScreen,
      );
    } else {
      Get.offAllNamed(Routes.signIn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Todo App",
                style: CustomTextStyle.heading2(),
              ),
            ),
            FadeIn(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(
                  ImageConstants.splashLottieUrl,
                  animate: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
