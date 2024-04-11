// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';
// Project imports:
import '../../../presentation/view/common/custom_padding.dart';
import 'information_page.dart';

class ResponsiveLayout extends StatefulWidget {
  final Function(BuildContext context, InformationPage info) builder;
  final Color? backgroundColor;
  final String? titleAppBar;
  final bool? isPadding;
  final bool? resizeToAvoidBottomInset;
  final bool? showAppBar;
  final bool? showAppBarActions;
  final VoidCallback? onBack;

  const ResponsiveLayout({
    super.key,
    required this.builder,
    this.titleAppBar,
    this.backgroundColor,
    this.isPadding = true,
    this.resizeToAvoidBottomInset = false,
    this.onBack,
    this.showAppBar = true,
    this.showAppBarActions = false,
  }) : assert((showAppBar == true && titleAppBar != null) || showAppBar == false);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    InformationPage infoPage = InformationPage(
      screenWidth: context.sizeSide.width,
      screenHeight: context.sizeSide.height,
    );

    return PopScope(
      canPop: true,
      onPopInvoked: (isPop) {
        widget.onBack?.call();
      },
      child: SafeArea(
        maintainBottomViewPadding: true,
        top: false,
        bottom: true,
        left: false,
        right: false,
        child: Scaffold(
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          extendBody: true,
          backgroundColor: widget.backgroundColor,
          body: SafeArea(
            maintainBottomViewPadding: true,
            top: false,
            child: SizedBox(
              height: infoPage.screenHeight,
              width: infoPage.screenWidth,
              child: CustomPadding(
                  top: widget.isPadding! ? infoPage.screenWidth * (context.orientationInfo.isPortrait ? 0.03 : 0.01) : 0.0,
                  start: widget.isPadding! ? infoPage.screenWidth * 0.03 : 0.0,
                  end: widget.isPadding! ? infoPage.screenWidth * 0.03 : 0.0,
                  bottom: !widget.resizeToAvoidBottomInset! ? context.viewInsets.bottom : null,
                  child: Builder(
                    builder: (context) {
                      infoPage = infoPage.copyWith(context: context);
                      return widget.builder(context, infoPage);
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
