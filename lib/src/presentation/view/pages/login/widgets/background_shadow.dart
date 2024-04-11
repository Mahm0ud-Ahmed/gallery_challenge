import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';
import 'package:gellary_challenge/src/core/utils/layout/information_page.dart';

import '../../../../../core/config/assets/assets.gen.dart';
import '../../../common/image_widget.dart';

class BackgroundShadow extends StatelessWidget {
  final InformationPage info;
  const BackgroundShadow({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(
          top: info.screenHeight * .05,
          start: -info.screenWidth * .1,
          child: SizedBox(
            width: info.screenWidth * 1.2,
            height: info.screenHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(info.screenHeight),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffEA94D7),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          start: -info.screenWidth * .1,
          top: info.screenHeight * .35,
          child: SizedBox(
            width: info.screenWidth * 1.5,
            height: info.screenHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(info.screenHeight),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffFFDADA),
                    blurRadius: 100,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: -info.screenHeight * .1,
          end: -info.screenWidth * .55,
          child: SizedBox(
            width: info.screenWidth * 1.2,
            height: info.screenHeight * .75,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(info.screenHeight),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffDDCDFF),
                    blurRadius: 100,
                    spreadRadius: 10,
                    // offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -info.screenHeight * .5,
          right: 0,
          left: 0,
          top: info.screenHeight * .8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(.75),
                  blurRadius: 100,
                  spreadRadius: 10,
                ),
              ],
            ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget(
                        height: 120,
                        width: 120,
                        image: Assets.images.imagePlaceholder,
                        fit: BoxFit.contain,
                      ),
                      (info.screenWidth * .1).w,
                      ImageWidget(
                        height: 180,
                        width: 180,
                        image: Assets.images.circuler,
                        fit: BoxFit.contain,
                      ),
                    ],
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
        )
      ],
    );
  }
}
