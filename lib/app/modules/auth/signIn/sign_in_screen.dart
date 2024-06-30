// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/app/modules/auth/signIn/sign_in_controller.dart';
import 'package:task_management/app/routes/pages.dart';
import 'package:task_management/components/custom_button.dart';
import 'package:task_management/components/custom_text_fIeld.dart';
import 'package:task_management/components/divider_with_text.dart';
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  final SignInController _signInController = Get.put(SignInController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.background(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'SIGN IN',
                    style: CustomTextStyle.heading2(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomTextField(
                      textEditingController:
                          _signInController.emailTextController.value,
                      hintText: 'johndeo',
                      nameText: 'Email',
                      onChanged: (String value) {
                        _signInController.emailTextController.refresh();
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => CustomTextField(
                      textEditingController:
                          _signInController.passwordTextController.value,
                      hintText: 'Password (min. 6 characters)',
                      nameText: 'Password',
                      obscureText: !_signInController.passwordVisible.value,
                      onChanged: (String value) {
                        _signInController.passwordTextController.refresh();
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          !_signInController.passwordVisible.value
                              ? Icons.remove_red_eye_rounded
                              : Icons.remove_red_eye_sharp,
                          color: ColorSchema.midGray3(),
                        ),
                        onPressed: () {
                          _signInController.passwordVisible.value =
                              !_signInController.passwordVisible.value;
                        },
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        } else if (value.length < 6) {
                          return "Password should be minimum 6 character";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _signInController.login();
                          }
                        },
                        title: 'Sign In',
                        buttonType: _signInController.getButtonType(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const DividerWithText(text: 'NOT REGISTERED YET?'),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(
                            onTap: () {
                              Get.offAllNamed(Routes.signUp);
                            },
                            backgroundColor: ColorSchema.universalSwap(),
                            titleColor: ColorSchema.background(),
                            title: 'Create an account',
                            buttonType: ButtonType.enable,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
