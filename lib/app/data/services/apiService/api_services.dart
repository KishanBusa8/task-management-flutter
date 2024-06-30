// Package imports:
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/app/routes/pages.dart';
import 'package:task_management/helpers/constants/api_constants.dart';
import 'package:task_management/helpers/constants/storage_constants.dart';

class ApiMethodType {
  static const String post = "POST";
  static const String patch = "PATCH";
  static const String get = "GET";
  static const String put = "PUT";
  static const String delete = "DELETE";
}

class ApiService extends GetConnect {
  Future<Response> makeApiCall(
    String baseUrl,
    String method, {
    dynamic params,
    Map<String, dynamic>? headers,
  }) async {
    Response<dynamic>? response;
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.timeout = const Duration(
      minutes: 3,
    );

    // HEADER
    httpClient.addRequestModifier<dynamic>((Request<dynamic> request) async {
      // request.headers["Content-Type"] = "multipart/form-data;";
      request.headers["Authorization"] =
          "Bearer ${GetStorage().read(StorageConstants.token)}";
      return request;
    });
    if (method == ApiMethodType.post) {
      response = await post(
        baseUrl,
        params,
      );
    } else if (method == ApiMethodType.get) {
      response = await get(
        baseUrl,
        query: params,
      );
    } else if (method == ApiMethodType.put) {
      response = await put(
        baseUrl,
        params,
      );
    } else if (method == ApiMethodType.patch) {
      response = await patch(
        baseUrl,
        params,
      );
    } else if (method == ApiMethodType.delete) {
      response = await delete(
        baseUrl,
        query: params,
      );
    }
    if (response?.statusCode == 401 &&
        !(response?.request?.url.toString().contains(ApiConstants.signIn) ??
            false)) {
      Get.offAllNamed(Routes.signIn);
      return const Response(
        body: {'error': 'unauthorized'},
        statusCode: 401,
      );
    }
    return response ??
        const Response(
          body: {'error': 'something went wrong'},
          statusCode: 500,
        );
  }
}
