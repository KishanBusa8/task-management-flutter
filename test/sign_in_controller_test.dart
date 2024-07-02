import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:task_management/app/data/models/user_model.dart';
import 'package:task_management/app/data/services/global/global_controller.dart';
import 'package:task_management/helpers/constants/storage_constants.dart';

import 'mocks.mocks.dart';
import 'test_data/test_data_loader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('signInControllerTest -', () {
    late MockSignInController signInController;
    late GlobalController globalController;
    String email = 'kishan@gmail.com';
    String password = 'a123123';
    final _loginResponse = loadData('./test/test_data/login_response.json');
    final Map<String, String> _header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    const channel = MethodChannel('plugins.flutter.io/path_provider');
    void setUpMockChannels(MethodChannel channel) {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return '.';
        }
      });
    }

    setUpAll(() async {
      setUpMockChannels(channel);
    });

    setUp(() async {
      await GetStorage.init();
      globalController = Get.put(GlobalController());
      signInController = MockSignInController();
      when(signInController.emailTextController)
          .thenAnswer((a) => TextEditingController(text: email).obs);
      when(signInController.passwordTextController)
          .thenAnswer((a) => TextEditingController(text: password).obs);
    });

    group('login -', () {
      test('Check if email and password is set or not', () async {
        expect(signInController.emailTextController.value.text, email);
        expect(signInController.passwordTextController.value.text, password);
      });
      test('When login is called, it should call login api', () async {
        when(await signInController.login()).thenAnswer((e) async {});
        await signInController.login();
        verify(
          signInController.login(),
        ).called(1);
      });
    });

    test('When login is called, it should set the user in to global controller',
        () async {
      when(await signInController.login()).thenAnswer((e) async {
        globalController.user.value = User.fromJson(_loginResponse['user']);
      });
      await signInController.login();
      verify(
        signInController.login(),
      ).called(1);
      expect(globalController.user.value.email, email);
    });

    test('When login is called, it should set the user in to global controller',
        () async {
      when(await signInController.login()).thenAnswer((e) async {
        globalController.user.value = User.fromJson(_loginResponse['user']);
        await GetStorage()
            .write(StorageConstants.token, _loginResponse['token']);
        await GetStorage().write(
          StorageConstants.user,
          jsonEncode(_loginResponse['user']),
        );
      });
      await signInController.login();
      verify(
        signInController.login(),
      ).called(1);
      expect(globalController.user.value.email, email);
      expect(
          GetStorage().read(StorageConstants.token), _loginResponse['token']);
      expect(GetStorage().read(StorageConstants.user),
          jsonEncode(_loginResponse['user']));
    });
  });
}
