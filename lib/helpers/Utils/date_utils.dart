// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

class DateUtilities {
  static const String kMainSourceFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";

  static const kSourceFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
  static const String dd_mm_yyyy_hh_mm = "dd-MM-yyyy HH:mm";
  static const String dd_mm_yyyy_hh_mm_a = "dd-MM-yyyy hh:mm a";
  static const String dd_mm_yyyy_hh_mm_ss_a = "dd/MM/yyyy',' hh:mm a";
  static const String dd_mm_yyyy_hh_mm_ss_aa = "dd-MM-yyyy' at 'hh:mm a";
  static const String dd_mm_hh_mm_ss_aa = "dd-MMM' at 'hh:mm a";
  static const String dd_mm_yyyy_hh_mm_ss = "dd MMM yyyy',' hh:mm a";
  static const String dd_mm_yyyy_n_mm_ss_a = "dd/MM/yyyy'\n' hh:mm a";
  static const String dd_mm_yyyy = "dd MMM yyyy";
  static const String mmmm_dd_yyyy = "MMMM dd yyyy";
  static const String mmm_yyyy = "MMM yyyy";
  static const String dd_mmm = "dd MMM";
  static const String dd_eee = "dd\nEE";
  static const String mm_yyyy = "MM/yyyy";
  static const String dd = "d";
  static const String mmmm = "MMMM";
  static const String mmm = "MMM";
  static const String yyyy = "yyyy";
  static const String file_name_date = "dd MMM yyyy";
  static const String dd_mm_yyyy_ = "dd-MM-yyyy";
  static const String yyyy_mm_dd = "yyyy-MM-dd";

  static const String ddmmyyyy = "dd/MM/yyyy";
  static const String mmddyyyy = "MM/dd/yyyy";

  static const String ddmmyywithdash = "dd-MM-yyyy";
  static const String hh_mm_ss = "HH:mm:ss";
  static const String hh_mm_a = "hh:mm a";
  static const String h_mm_a = "h:mm a";
  static const String hh_mm = "HH:mm";
  static const String eeee = "EEEE";
  static const String ee = "EE";
  static const String eee_dd_mmm_yyyy = "EEEE, dd MMM yyyy";

  static const String dd_mmm_yyy_h_mm_a = "dd MMM yyyy',' h:mma";

  static const String mmm_withComma_yyyy = "MMMM, yyyy";
  static const String date_And_month = "d MMMM";
  static const String hour_minute = "jm";

  String convertServerDateToFormatterString(
    String dateString, {
    String? formatter,
  }) {
    // ignore: unnecessary_null_comparison
    if (dateString == "" || dateString == null) return "";
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      DateTime.parse(dateString).millisecondsSinceEpoch,
    ).toLocal();
    return getFormattedDateString(
      getDateFromString(dateTime.toIso8601String(), formatter: kSourceFormat),
      formatter: formatter,
    );
  }

  String getFormattedDateString(DateTime date, {String? formatter}) {
    // ignore: prefer_conditional_assignment
    if (formatter == null) {
      formatter = kMainSourceFormat;
    }
    return DateFormat(formatter).format(date);
  }

  DateTime getDateFromString(String dateString, {String? formatter}) {
    // ignore: prefer_conditional_assignment
    if (formatter == null) {
      formatter = kMainSourceFormat;
    }

    //It is must to put (true) flag inside pars, bcz its for utc = true;
    //we have to explicitly provide that flag that we wanna convert utl
    //to local time format.
    return DateFormat(formatter).parse(dateString, true);
  }

  static String getStringFromString(String dateString, {String? formatter}) {
    // ignore: prefer_conditional_assignment
    if (formatter == null) {
      formatter = kMainSourceFormat;
    }

    //It is must to put (true) flag inside pars, bcz its for utc = true;
    //we have to explicitly provide that flag that we wanna convert utl
    //to local time format.
    final date = DateFormat(formatter).parse(dateString, true);
    final DateFormat formatter1 = DateFormat(formatter);
    return formatter1.format(date);
  }

  static String converDateTimeToString({
    required DateTime date,
    String dateFormatter = yyyy_mm_dd,
  }) {
    final DateFormat formatter = DateFormat(dateFormatter);
    return formatter.format(date);
  }
}
