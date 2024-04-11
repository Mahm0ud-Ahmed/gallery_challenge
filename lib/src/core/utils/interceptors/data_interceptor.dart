// Package imports:
import 'package:dio/dio.dart';

import '../../config/injector.dart';
import '../../services/storage_service.dart';
import '../constant.dart';

class DataInterceptor extends Interceptor {
  DataInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Authorization': _getToken,
    });
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  String? get _getToken {
    token ??= injector<StorageService>().getString(kUserToken);
    if (token != null && token!.isNotEmpty) {
      return 'Bearer $token';
    }
    return null;
  }
}
