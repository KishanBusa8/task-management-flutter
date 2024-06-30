import 'package:get/get.dart';
import 'package:task_management/l10n/app_en.dart';
import 'package:task_management/l10n/app_hi.dart';
import 'package:task_management/l10n/app_pt.dart';
// import 'package:stock_management/l10n/app_en.dart';
// import 'package:stock_management/l10n/app_hi.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
        'hi': HindiTexts.texts,
        'pt': PortuguesTexts.texts,
        'en': EnglishTexts.texts,
      };
}
