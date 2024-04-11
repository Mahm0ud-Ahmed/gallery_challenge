// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';
import 'package:gellary_challenge/src/presentation/view_model/blocs/data_bloc/api_data_state.dart';

import '../../../../core/config/injector.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/api_info.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/enums.dart';
import '../../../../data/models/user_model.dart';
import '../../../view_model/blocs/data_bloc/api_data_bloc.dart';
import '../../common/text_widget.dart';
import '../home/home_page.dart';

class LoginController {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController userNameController;
  late final TextEditingController passwordController;
  late final ValueNotifier<bool> isObscure;

  late final ApiDataBloc<Map<String, dynamic>> apiDataBloc;

  UserModel? user;

  LoginController() {
    formKey = GlobalKey<FormState>();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    isObscure = ValueNotifier<bool>(true);
    apiDataBloc = ApiDataBloc<Map<String, dynamic>>();
  }

  void listener(BuildContext context, ApiDataState state) {
    state.mapOrNull(
      success: (data) {
        user = UserModel.fromJson(data.data!);
        if (user != null) {
          injector<StorageService>().saveString(kUserToken, user!.token);
          context.push(const HomePage());
        }
      },
      error: (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: TextWidget(
            text: error.error?.errorMessage ?? '',
            style: context.bodyM!.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      },
    );
  }

  void onSubmit(ApiDataState state) {
    state.maybeMap(
      orElse: () {
        if (formKey.currentState!.validate()) {
          apiDataBloc.postData(
            info: ApiInfo(
              endpoint: ApiRoute.login.route,
              body: {'email': userNameController.text.trim(), 'password': passwordController.text},
              requestType: ApiRequestType.post,
            ),
          );
        }
      },
    );
  }

  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    isObscure.dispose();
    user = null;
  }
}
