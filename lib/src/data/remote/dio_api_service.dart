// Package imports:
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gellary_challenge/src/core/utils/enums.dart';

import '../../core/error/app_exception.dart';
import '../../core/utils/api_info.dart';

class DioApiService {
  final Dio dio;
  DioApiService({
    required this.dio,
  });

  Future<Response> action({
    required ApiInfo query,
    ProgressCallback? progress
  }) async {
    switch (query.requestType) {
      case ApiRequestType.get:
        return await _getData(query: query);
      case ApiRequestType.post:
        return await _postData(query: query, progress: progress);
    }
  }

  Future<Response> _getData({
    required ApiInfo query,
  }) async {
    try {
      final response = await dio.get(query.endpoint);
      if (response.statusCode == HttpStatus.ok) {
        return response;
      }
      throw (AppException(response.data));
    } catch (error) {
      throw (AppException(error));
    }
  }

  Future<Response> _postData({required ApiInfo query, ProgressCallback? progress}) async {
    try {
      final FormData formData;
      if (query.body!.containsKey('img')) {
        formData = FormData.fromMap({'img': MultipartFile.fromFileSync(query.body!['img'])}, ListFormat.multiCompatible);
      } else {
        formData = FormData.fromMap(query.body!, ListFormat.multiCompatible);
      }
      final response = await dio.post(
        query.endpoint,
        onSendProgress: progress,
        // cancelToken: cancelRequest,
        options: Options(headers: {'Content-Type': Headers.formUrlEncodedContentType}),
        data: formData,
      );
      if (response.statusCode == HttpStatus.ok) {
        return response;
      }
      throw (AppException(response.data));
    } catch (error) {
      throw (AppException(error));
    }
  }
}
