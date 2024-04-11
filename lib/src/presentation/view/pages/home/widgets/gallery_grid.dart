import 'package:flutter/material.dart';

class GalleryGrid extends StatelessWidget {
  final int length;
  final Widget Function(int index) itemBuilder;
  const GalleryGrid({super.key, required this.length, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 160,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => itemBuilder(index),
    );
  }
}
