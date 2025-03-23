import 'package:flutter/material.dart';

/// A custom SliverGridDelegate to ensure fixed height for grid items
class SliverGridDelegateWithFixedCrossCountAndFixedHeight
    extends SliverGridDelegateWithFixedCrossAxisCount {
  const SliverGridDelegateWithFixedCrossCountAndFixedHeight({
    required int crossCount,
    required this.height,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
  }) : super(
         crossAxisCount: crossCount,
         mainAxisSpacing: mainAxisSpacing,
         crossAxisSpacing: crossAxisSpacing,
         childAspectRatio: childAspectRatio,
       );

  final double height;

  @override
  double getMainAxisExtent(double crossAxisExtent) {
    return height;
  }
}
