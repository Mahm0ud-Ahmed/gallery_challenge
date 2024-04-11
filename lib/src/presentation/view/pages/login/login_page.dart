import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/utils/layout/responsive_layout.dart';

import '../../common/background_shadow.dart';
import 'widgets/body_login.dart';
import 'widgets/camera_threads.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      showAppBar: false,
      isPadding: false,
      builder: (context, info) {
        return Stack(
          children: [
            BackgroundShadow(info: info),
            CameraThreads(info: info),
            BodyLogin(info: info),
          ],
        );
      },
    );
  }
}
