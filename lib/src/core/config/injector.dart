import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:gellary_challenge/src/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:gellary_challenge/src/core/utils/theme_manager.dart';

import '../../data/remote/dio_api_service.dart';
import '../../presentation/view_model/blocs/assistance/my_bloc_observer.dart';
import '../services/dio_service.dart';
import '../utils/constant.dart';

final injector = GetIt.instance;
String? token;

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  injector.registerSingleton<StorageService>(StorageService());
  await injector<StorageService>().initializeService();

  token = injector<StorageService>().getString(kUserToken);

  injector.registerSingleton<DioService>(DioService());
  await injector<DioService>().initializeService();

  injector.registerSingleton<DioApiService>(DioApiService(dio: injector<DioService>().dio));

  injector.registerSingleton<ThemeManager>(ThemeManager());

  Bloc.observer = MyBlocObserver();
}
