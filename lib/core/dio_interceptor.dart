import 'dart:developer';

import 'package:clinic_admin/core/routes/go_routes.dart';
import 'package:clinic_admin/core/routes/routes.dart';
import 'package:clinic_package/clinic_package.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

class DioInterceptor implements Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.message!.contains("401")) {
      preferences.clear();
      navigatorKey.currentContext!.goNamed(Routes.login);
    }

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = preferences.getString(SharedKeys.accessToken);
    options.headers["Authorization"] = "Bearer $token";
    log("=======================================");
    log("Request");
    log("url:=> ${options.path}");
    log("content:=> ${options.contentType}");
    log("headers:=> hasToken:${token != null}");
    log("body:=> ${options.data != null ? options.data! : "Data is null"}");
    log("=======================================");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("=======================================");
    log("Response:");
    log("url:=> ${response.requestOptions.path}");
    log("statusCode:=> ${response.statusCode}");
    log("body:=> hasData: ${response.data != null}");
    log("=======================================");
    handler.next(response);
  }
}
