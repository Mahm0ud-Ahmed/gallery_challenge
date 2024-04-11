import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';

import '../../../../../core/config/assets/assets.gen.dart';
import '../../../../../core/utils/constant.dart';
import '../../../common/image_widget.dart';
import '../../../common/text_widget.dart';

class UserAppBar extends StatelessWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.isMobile ? 150 : 300,
          child: TextWidget(
            text: 'Welcome Mina',
            style: context.headlineS,
          ),
        ),
        SizedBox(
          height: 100,
          width: 100,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(250),
              color: kSecondColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipOval(
                child: ImageWidget(
                  image: Assets.images.user,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
