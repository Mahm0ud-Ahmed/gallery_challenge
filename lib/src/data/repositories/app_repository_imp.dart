import 'package:dio/dio.dart';
import 'package:gellary_challenge/src/core/utils/api_info.dart';
import 'package:gellary_challenge/src/core/utils/data_state.dart';
import 'package:gellary_challenge/src/data/models/api_response_model.dart';
import 'package:gellary_challenge/src/data/repositories/parsing_power.dart';

import '../../core/error/app_exception.dart';
import '../remote/dio_api_service.dart';
import 'interfaces/i_remote_repository.dart';

class AppRepositoryImp<T> extends IRemoteRepository<T> {
  final DioApiService dioApiService;
  AppRepositoryImp({
    required this.dioApiService,
  });

  @override
  Future<DataState<ApiResponseModel<T>>> getSingleData(apiInfo) async {
    try {
      final response = await dioApiService.action(query: apiInfo);
      final responseModel = parseApiResponse<T>(response.data);

      return DataState<ApiResponseModel<T>>.success(responseModel, response.data);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  Future<DataState<T>> postData(ApiInfo apiInfo, ProgressCallback? progress) async{
    try {
      final response = await dioApiService.action(query: apiInfo, progress: progress);
      final responseModel = parseModel<T>(response.data);

      return DataState<T>.success(responseModel, response.data);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

}
