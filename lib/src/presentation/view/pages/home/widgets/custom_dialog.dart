import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gellary_challenge/src/core/utils/api_info.dart';
import 'package:gellary_challenge/src/core/utils/enums.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';
import 'package:gellary_challenge/src/presentation/view/pages/home/widgets/custom_button.dart';
import 'package:gellary_challenge/src/presentation/view_model/blocs/data_bloc/api_data_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/config/assets/assets.gen.dart';
import '../../../../view_model/blocs/data_bloc/api_data_state.dart';
import '../../../../view_model/pick_image_helper.dart';
import '../../../common/text_widget.dart';

class CustomDialog extends StatefulWidget {
  final ValueNotifier<bool> isDialogOpen;
  final ApiDataBloc apiDataBloc;

  const CustomDialog({
    super.key,
    required this.isDialogOpen,
    required this.apiDataBloc,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late final ApiDataBloc apiDataBlocAction;
  late PickImageHelper? pickImageHelper;

  @override
  void initState() {
    super.initState();
    apiDataBlocAction = ApiDataBloc();
    pickImageHelper = PickImageHelper(
      error: (error) {
        if (context.mounted) {
          showSnackBar(error.message ?? '');
        }
      },
    );
  }

  @override
  void dispose() {
    apiDataBlocAction.close();
    pickImageHelper = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.isDialogOpen,
      builder: (context, value, child) {
        if (value) {
          return BlocListener<ApiDataBloc, ApiDataState>(
            bloc: apiDataBlocAction,
            listener: (context, state) {
              state.mapOrNull(
                success: (value) {
                  widget.apiDataBloc.getGeneralData(
                    info: ApiInfo(
                      endpoint: ApiRoute.gallery.route,
                      requestType: ApiRequestType.get,
                    ),
                  );
                  widget.isDialogOpen.value = false;
                },
                error: (value) => showSnackBar(value.error?.errorMessage ?? ''),
              );
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: context.isMobile ? 350 : 420,
                      height: 200,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: BlocBuilder<ApiDataBloc, ApiDataState>(
                              bloc: apiDataBlocAction,
                              builder: (context, state) {
                                return state.maybeMap(
                                  loading: (value) => Center(
                                    child: LinearProgressIndicator(
                                      color: const Color(0xff7BB3FF),
                                      value:
                                          value.count != null && value.total != null ? (value.count! / value.total!) : null,
                                    ),
                                  ),
                                  orElse: () => Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomButton(
                                        width:0,
                                        onPressed: () => pickImage(ImageSource.gallery),
                                        text: 'Gallery',
                                        image: Assets.images.gallery,
                                      ),
                                      CustomButton(
                                        width: 180,
                                        onPressed: () => pickImage(ImageSource.camera),
                                        text: 'Camera',
                                        image: Assets.images.camera,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: TextWidget(
        text: message,
      ),
      backgroundColor: Colors.red,
    ));
  }

  void pickImage(ImageSource source) {
    pickImageHelper?.pick(source).then((value) {
      if (value != null) {
        apiDataBlocAction.postData(
          info: ApiInfo(
            endpoint: ApiRoute.uploadImg.route,
            requestType: ApiRequestType.post,
            body: {'img': value.path},
          ),
        );
      }
    });
  }
}
