import 'package:flutter/material.dart';

/// A thin horizontal line that mimics the system navigation gesture indicator
class NavigationHandle extends StatelessWidget {
  final double width;
  final Color color;
  final double height;
  final VoidCallback? onTap;

  const NavigationHandle({
    super.key,
    this.width = 100,
    this.color = Colors.white,
    this.height = 4,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(height / 2),
          // Add a subtle border/outline to make it visible against any background
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 0.5),
          // Add a subtle shadow for additional visibility
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 0.5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
