import 'package:flutter/material.dart';

/// A widget that adapts its layout based on screen size.
/// It shows different content for desktop and mobile layouts.
class AdaptiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final double breakpoint;

  const AdaptiveLayout({
    super.key,
    required this.mobile,
    required this.desktop,
    this.breakpoint = 600, // Default breakpoint for mobile/desktop separation
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          return mobile;
        } else {
          return desktop;
        }
      },
    );
  }
}
