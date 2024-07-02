import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:task_management/app/data/services/apiService/api_services.dart';
import 'package:task_management/app/modules/auth/signIn/sign_in_controller.dart';
import 'package:task_management/app/modules/auth/sign_up/sign_up_controller.dart';
import 'package:task_management/app/modules/home/home_controller.dart';
import 'package:task_management/helpers/Utils/common_functions.dart';

@GenerateMocks(
  [
    ApiService,
    CommonFunctions,
    GetConnect,
    GetHttpClient,
    SignInController,
    SignUpController,
    HomeController,
  ],
  customMocks: [],
)
void main() {}
