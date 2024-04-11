import 'package:gellary_challenge/src/presentation/view_model/blocs/data_bloc/api_data_bloc.dart';

import '../../../../core/config/injector.dart';
import '../../../../core/utils/api_info.dart';
import '../../../../data/repositories/app_repository_imp.dart';
import '../../../../data/repositories/interfaces/i_remote_repository.dart';

class BaseBlocHelper<MODEL> {
  final ApiDataBloc<MODEL> cubit;

  IRemoteRepository<MODEL>? repository;
  ApiInfo? apiInfo;

  BaseBlocHelper({
    required this.cubit,
    this.repository,
    this.apiInfo,
  }) {
    repository = AppRepositoryImp(dioApiService: injector());
  }

}
