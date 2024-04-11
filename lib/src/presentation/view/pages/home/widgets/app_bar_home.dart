import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/utils/layout/information_page.dart';
import 'package:gellary_challenge/src/presentation/view/pages/home/widgets/btn_app_bar.dart';
import 'package:gellary_challenge/src/presentation/view/pages/home/widgets/user_app_bar.dart';


class AppBarHome extends StatelessWidget {
  final InformationPage info;
  final ValueNotifier<bool> isDialogOpen;
  const AppBarHome({
    super.key,
    required this.info,
    required this.isDialogOpen,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 160.0,
      leading: const SizedBox.shrink(),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const UserAppBar(),
              BtnAppBar(isDialogOpen: isDialogOpen),
            ],
          ),
        ),
      ),
    );
  }
}
