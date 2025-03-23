import 'package:flutter/material.dart';

/// A thin horizontal line that mimics the system navigation gesture indicator
class NavigationHandle extends StatelessWidget {
  final double width;
  final Color color;
  final double height;
  final VoidCallback? onTap;

  const NavigationHandle({
    super.key,
    this.width = 160, // Increased width from 120 to 160
    this.color = Colors.white,
    this.height = 6, // Increased height from 5 to 6
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(height / 2),
          border: Border.all(color: Colors.white.withOpacity(0.9), width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 3,
              spreadRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.7),
            borderRadius: BorderRadius.circular((height - 2) / 2),
          ),
        ),
      ),
    );
  }
}
