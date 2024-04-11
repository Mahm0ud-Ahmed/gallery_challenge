// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gellary_challenge/src/data/models/api_response_model.dart';

// Project imports:
import '../../../../core/error/error.dart';
import '../../../../core/utils/api_info.dart';
import '../../../../core/utils/data_state.dart';
import '../assistance/base_bloc_helper.dart';
import 'api_data_state.dart';

class ApiDataBloc<MODEL> extends Cubit<ApiDataState<MODEL>> {
  BaseBlocHelper<MODEL>? _helper;
  final ApiInfo? apiInfo;

  ApiDataBloc({this.apiInfo}) : super(const ApiDataIdle()) {
    _helper = BaseBlocHelper<MODEL>(cubit: this, apiInfo: apiInfo);
  }

  Future<void> getGeneralData({required ApiInfo info}) async {
    emit(ApiDataLoading<MODEL>());
    final DataState<ApiResponseModel<MODEL>> dataState = await _helper!.repository!.getSingleData(info);
    dataState.when(
      success: (successState, response) {
        if (response.containsKey('error_message')) {
          _emitError(AppError(errorMessage: response['error_message']));
        } else {
          emit(ApiDataSuccessModel<MODEL>(data: successState.data));
        }
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  Future<void> postData({required ApiInfo info}) async {
    emit(ApiDataLoading<MODEL>());
    final DataState<MODEL> dataState = await _helper!.repository!.postData(info, (count, total) {
      emit(ApiDataLoading<MODEL>(count: count, total: total));
    });
    dataState.when(
      success: (successState, response) {
        if (response.containsKey('error_message')) {
          _emitError(AppError(errorMessage: response['error_message']));
        } else {
          emit(ApiDataSuccessModel<MODEL>(data: successState));
        }
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  void _emitError(
    AppError errorState,
  ) {
    emit(ApiDataError<MODEL>(error: errorState));
  }

  @override
  Future<void> close() {
    _helper!.repository = null;
    _helper = null;
    return super.close();
  }
}
