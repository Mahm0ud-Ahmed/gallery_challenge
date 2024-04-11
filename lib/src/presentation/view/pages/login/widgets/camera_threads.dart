import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';
import 'package:gellary_challenge/src/core/utils/layout/information_page.dart';

import '../../../../../core/config/assets/assets.gen.dart';
import '../../../common/image_widget.dart';

class CameraThreads extends StatelessWidget {
  final InformationPage info;
  const CameraThreads({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(
          top: 0,
          start: 0,
          end: 0,
          bottom: 0,
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                PositionedDirectional(
                  top: -info.screenHeight * (context.isMobile ? .1 : .12),
                  start: -info.screenWidth * (context.isMobile ? .15 : .1),
                  child: ImageWidget(image: Assets.images.threads, height: context.sizeSide.largeSide * (context.isMobile ? .39 : .45),),
                ),
                PositionedDirectional(
                  top: constraints.maxHeight * (context.isMobile ? .12 : .15),
                  start: constraints.maxWidth * (context.isMobile ? .2 : .25),
                  child: ImageWidget(image: Assets.images.cameraLogin),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
