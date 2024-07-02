import 'dart:convert';
import 'dart:io';

Map<String, dynamic> loadData(String path) {
  return jsonDecode(File(path).readAsStringSync());
}

String loadStrData(String path) {
  return File(path).readAsStringSync();
}
