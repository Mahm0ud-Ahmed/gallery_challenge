import 'package:flutter/material.dart';

import '../../../common/image_widget.dart';
import '../../../common/text_widget.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  final dynamic image;
  final String text;
  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.onPressed,
    this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      height: height ?? 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: ImageWidget(image: image),
        label: TextWidget(text: text),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
