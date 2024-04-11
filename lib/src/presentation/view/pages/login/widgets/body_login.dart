import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';
import 'package:gellary_challenge/src/core/utils/layout/information_page.dart';
import 'package:gellary_challenge/src/presentation/view/pages/login/login_controller.dart';
import 'package:gellary_challenge/src/presentation/view/pages/login/widgets/fields_login.dart';
import 'package:gellary_challenge/src/presentation/view_model/blocs/data_bloc/api_data_bloc.dart';

import '../../../../../core/config/l10n/generated/l10n.dart';
import '../../../../view_model/blocs/data_bloc/api_data_state.dart';
import '../../../common/text_widget.dart';

class BodyLogin extends StatefulWidget {
  final InformationPage info;
  const BodyLogin({super.key, required this.info});

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  late final LoginController _controller;
  @override
  void initState() {
    super.initState();
    _controller = LoginController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (widget.info.screenHeight * .28).h,
            SizedBox(
              width: context.isMobile ? 200 : 400,
              child: TextWidget(
                text: S.of(context).login_page_my_gallery,
                textAlign: TextAlign.center,
                style: context.headlineL,
              ),
            ),
            (widget.info.screenHeight * .03).h,
            Container(
              margin: EdgeInsets.symmetric(horizontal: widget.info.screenWidth * .05),
              padding: EdgeInsets.all(widget.info.screenWidth * .05),
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(20),
              ),
              child: BlocListener<ApiDataBloc<Map<String, dynamic>>, ApiDataState<Map<String, dynamic>>>(
                bloc: _controller.apiDataBloc,
                listener: _controller.listener,
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'LOG IN',
                        style: context.headlineS,
                      ),
                      (widget.info.screenHeight * .04).h,
                      FieldsLogin(
                        controller: _controller,
                      ),
                      (widget.info.screenHeight * .04).h,
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: BlocBuilder<ApiDataBloc<Map<String, dynamic>>, ApiDataState<Map<String, dynamic>>>(
                          bloc: _controller.apiDataBloc,
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff7BB3FF),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () => _controller.onSubmit(state),
                              child: state.maybeMap(
                                loading: (_) => const CircularProgressIndicator(color: Colors.white),
                                orElse: () => TextWidget(
                                  text: 'SUBMIT',
                                  style: context.bodyM!.copyWith(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            (widget.info.screenHeight * .1).h,
          ],
        ),
      ),
    );
  }
}
