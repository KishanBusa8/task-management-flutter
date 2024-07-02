// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    this.hintText = '',
    this.nameText = '',
    this.suffixIcon,
    this.optional = false,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.maxLines,
    this.onChanged,
    this.inputFormatters,
    this.enable = true,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  final String nameText;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool optional;
  final bool obscureText;
  final bool enable;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // if (nameText.isNotEmpty)
        //   Text.rich(
        //     TextSpan(
        //       text: nameText,
        //       style: CustomTextStyle.textFiled()
        //           .copyWith(color: ColorSchema().darkGray()),
        //       children: <InlineSpan>[],
        //     ),
        //   ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          controller: textEditingController,
          cursorColor: ColorSchema().universalSwap(),
          enabled: enable,
          style: CustomTextStyle.textFiled(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          maxLines: maxLines ?? 1,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: nameText,
            alignLabelWithHint: true,
            isDense: true,
            errorStyle: CustomTextStyle.textFiled()
                .copyWith(color: SingleColor.colorRed),
            hintStyle: CustomTextStyle.textFiled()
                .copyWith(color: ColorSchema().darkGray()),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorSchema().universalSwap()),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorSchema().midGray1()),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: SingleColor.colorRed),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
