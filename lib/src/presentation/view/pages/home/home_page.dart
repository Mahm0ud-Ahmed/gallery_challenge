import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/utils/api_info.dart';
import 'package:gellary_challenge/src/core/utils/enums.dart';
import 'package:gellary_challenge/src/core/utils/layout/responsive_layout.dart';
import 'package:gellary_challenge/src/presentation/view/pages/home/widgets/background_home.dart';
import 'package:gellary_challenge/src/presentation/view/pages/home/widgets/home_body.dart';
import 'package:gellary_challenge/src/presentation/view_model/blocs/data_bloc/api_data_bloc.dart';

import '../../../../core/utils/constant.dart';
import '../../../../data/models/gallery_model.dart';
import 'widgets/app_bar_home.dart';
import 'widgets/custom_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final ApiDataBloc<GalleryModel> apiDataBloc;
  late final ValueNotifier<bool> isDialogOpen;

  @override
  void initState() {
    super.initState();
    apiDataBloc = ApiDataBloc<GalleryModel>()
      ..getGeneralData(
        info: ApiInfo(endpoint: ApiRoute.gallery.route, requestType: ApiRequestType.get),
      );

    isDialogOpen = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      showAppBar: false,
      isPadding: false,
      builder: (context, info) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4, 1.0],
              colors: [
                kSecondColor,
                kFirstColor,
              ],
            ),
          ),
          child: Stack(
            children: [
              BackgroundHome(info: info),
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => isDialogOpen.value = false,
                  child: CustomScrollView(
                    slivers: [
                      AppBarHome(info: info, isDialogOpen: isDialogOpen),
                      HomeBody(apiDataBloc: apiDataBloc),
                    ],
                  ),
                ),
              ),
              CustomDialog(
                apiDataBloc: apiDataBloc,
                isDialogOpen: isDialogOpen,
              ),
            ],
          ),
        );
      },
    );
  }
}
