import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';
import 'package:gellary_challenge/src/core/utils/layout/information_page.dart';

import '../../../../../core/config/assets/assets.gen.dart';
import '../../../common/image_widget.dart';

class BackgroundHome extends StatelessWidget {
  final InformationPage info;
  const BackgroundHome({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: info.screenHeight * .2,
          child: ImageWidget(
            image: Assets.images.threads,
            height: context.sizeSide.largeSide * .3,
          ),
        ),
        PositionedDirectional(
          top: info.screenHeight / (context.isMobile ? 2.2 : 2.4),
          start: 0,
          end: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ImageWidget(
                            height: 120,
                            width: 120,
                            image: Assets.images.imagePlaceholder,
                            fit: BoxFit.contain,
                          ),
                        ),
                        (info.screenWidth * .1).w,
                        Flexible(
                          child: ImageWidget(
                            height: 180,
                            width: 180,
                            image: Assets.images.circuler,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ImageWidget(
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                    image: Assets.images.video,
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: const SizedBox.shrink(),
          ),
        ),
        const Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(200),
            ),
            child: ColoredBox(
              color: Colors.white60,
            ),
          ),
        ),
      ],
    );
  }
}
