import 'package:flutter/material.dart';
import 'package:task_management/helpers/schema/color_schema.dart';
import 'package:task_management/helpers/schema/text_styles.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 1,
            color: ColorSchema().lightGray(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Text(
            text,
            style: CustomTextStyle.textFiled()
                .copyWith(color: ColorSchema().midGray3()),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: ColorSchema().lightGray(),
          ),
        ),
      ],
    );
  }
}
