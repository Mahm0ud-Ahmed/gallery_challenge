import 'package:dio/dio.dart';
import 'package:gellary_challenge/src/core/utils/api_info.dart';
import 'package:gellary_challenge/src/core/utils/data_state.dart';

import '../../models/api_response_model.dart';

abstract class IRemoteRepository<T> {
  Future<DataState<ApiResponseModel<T>>> getSingleData(ApiInfo apiInfo);
  Future<DataState<T>> postData(ApiInfo apiInfo, ProgressCallback? progress);
}
