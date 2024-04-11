import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/config/injector.dart';
import 'package:gellary_challenge/src/core/config/l10n/generated/l10n.dart';
import 'package:gellary_challenge/src/core/services/storage_service.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';
import 'package:gellary_challenge/src/presentation/view/pages/login/login_page.dart';

import '../../../../../core/config/assets/assets.gen.dart';
import 'custom_button.dart';

class BtnAppBar extends StatelessWidget {
  final ValueNotifier<bool> isDialogOpen;
  const BtnAppBar({super.key, required this.isDialogOpen});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: CustomButton(
            onPressed: () {
              injector<StorageService>().clear().then((value) {
                context.push(const LoginPage());
              });
            },
            text: S.of(context).home_page_logout_btn,
            image: Assets.images.logout,
          ),
        ),
        (context.sizeSide.width * .05).w,
        Flexible(
          child: CustomButton(
            onPressed: () => isDialogOpen.value = true,
            text: S.of(context).home_page_upload_btn,
            image: Assets.images.upload,
          ),
        ),
      ],
    );
  }
}
