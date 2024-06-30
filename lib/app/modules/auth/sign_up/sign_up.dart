import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/app/modules/auth/sign_up/sign_up_controller.dart';
import 'package:task_management/components/custom_button.dart';
import 'package:task_management/components/custom_text_fIeld.dart';
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final SignUpController _signUpController = Get.put(SignUpController());
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
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'SIGN UP',
                  style: CustomTextStyle.heading(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => CustomTextField(
                    textEditingController:
                        _signUpController.emailTextController.value,
                    hintText: 'johndeo',
                    nameText: 'User Name',
                    onChanged: (String value) {
                      _signUpController.emailTextController.refresh();
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your user name";
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
                        _signUpController.passwordTextController.value,
                    hintText: 'Password (min. 6 characters)',
                    nameText: 'Password',
                    obscureText: !_signUpController.passwordVisible.value,
                    onChanged: (String value) {
                      _signUpController.passwordTextController.refresh();
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        !_signUpController.passwordVisible.value
                            ? Icons.remove_red_eye_rounded
                            : Icons.remove_red_eye_sharp,
                        color: ColorSchema.midGray3(),
                      ),
                      onPressed: () {
                        _signUpController.passwordVisible.value =
                            !_signUpController.passwordVisible.value;
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
                          _signUpController.signUp();
                        }
                      },
                      title: 'Sign UP',
                      buttonType: _signUpController.getButtonType(),
                    ),
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
    );
  }
}
