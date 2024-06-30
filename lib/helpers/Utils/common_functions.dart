// Flutter imports:
// Project imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:task_management/helpers/Utils/string.dart';
import 'package:task_management/helpers/schema/color_schema.dart';

class CommonFunctions {
  /// Empty Title & Subtite TextFields Warning
  emptyFieldsWarning() {
    Get.snackbar(
      MyString.oopsMsg,
      "You must fill all Fields!",
      colorText: Colors.white,
      backgroundColor: Colors.black54,
    );
  }

  /// Nothing Enter When user try to edit the current tesk
  nothingEnterOnUpdateTaskMode() {
    Get.snackbar(
      MyString.oopsMsg,
      "You must edit the tasks then try to update it!",
      colorText: Colors.white,
      backgroundColor: Colors.black54,
    );
  }

  /// No task Warning Dialog
  dynamic warningNoTask() {
    return PanaraInfoDialog.showAnimatedGrow(
      Get.context!,
      title: MyString.oopsMsg,
      message:
          "There is no Task For Delete!\n Try adding some and then try to delete it!",
      buttonText: "Okay",
      onTapDismiss: () {
        Get.back();
      },
      panaraDialogType: PanaraDialogType.warning,
    );
  }

  /// Delete All Task Dialog
  dynamic deleteAllTask({required VoidCallback onDelete}) {
    return PanaraConfirmDialog.show(
      Get.context!,
      title: MyString.areYouSure,
      message:
          "Do You really want to delete all tasks? You will no be able to undo this action!",
      confirmButtonText: "Yes",
      cancelButtonText: "No",
      onTapCancel: () {
        Get.back();
      },
      onTapConfirm: () {
        Get.back();
        onDelete();
      },
      panaraDialogType: PanaraDialogType.error,
      barrierDismissible: false,
    );
  }

  static bool isNullEmptyOrFalse(dynamic o) {
    if (o is Map<String, dynamic> || o is List<dynamic>) {
      return o == null || o.length == 0;
    }
    return o == null || false == o || "" == o;
  }

  Future<void> showLoadingDialog({bool isCancellable = false}) async {
    return showDialog<void>(
      context: Get.context!,
      barrierColor: Colors.black.withOpacity(0.6),
      barrierDismissible: isCancellable,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(builder: (context) {
            return WillPopScope(
              onWillPop: () async {
                return isCancellable;
              },
              child: const CupertinoActivityIndicator(
                color: Colors.white,
                radius: 18,
              ),
            );
          }),
        );
      },
    );
  }

  void showSnackBar({Color? backgroundColor, required String message}) {
    final Color background = backgroundColor ?? ColorSchema.universalSwap();
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        backgroundColor: background,
        duration: const Duration(milliseconds: 2300),
      ),
    );
  }

  void cupertinoDialog(
    BuildContext? context, {
    String? dialogTitle = "",
    String? dialogDesc = "",
    String? dialogConfirmTitle = "",
    List<Widget>? widgets,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          dialogTitle!,
        ),
        content: Text(
          dialogDesc!,
        ),
        actions: widgets ??
            <Widget>[
              CupertinoDialogAction(
                child: Text(
                  dialogConfirmTitle!,
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop("Discard");
                },
              ),
            ],
      ),
    );
  }

  static String convertServerDateToString(
    String date,
  ) {
    if (date.isEmpty) {
      return '';
    }
    return DateFormat.yMMMEd().format(
      DateFormat('yyyy-MM-ddThh:mm').parse(date),
    );
  }
}
