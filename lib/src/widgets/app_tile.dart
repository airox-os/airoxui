import 'package:flutter/material.dart';

/// A widget representing an application tile/icon in the OS
class AppTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const AppTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightTheme = theme.brightness == Brightness.light;

    // Create a colorful background based on the app name
    final colorSeed = label.hashCode % 5;
    final gradient = _getGradientForIndex(colorSeed);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _getGradientForIndex(int index) {
    switch (index) {
      case 0:
        return LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.7),
            Colors.deepPurple.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 1:
        return LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.7),
            Colors.lightBlue.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 2:
        return LinearGradient(
          colors: [Colors.green.withOpacity(0.7), Colors.teal.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 3:
        return LinearGradient(
          colors: [
            Colors.orange.withOpacity(0.7),
            Colors.amber.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 4:
      default:
        return LinearGradient(
          colors: [
            Colors.red.withOpacity(0.7),
            Colors.redAccent.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}
