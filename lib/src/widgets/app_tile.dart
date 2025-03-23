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

    // Unique geometry for each app based on name
    final uniqueShape = _getUniqueShapeForApp();

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glow effect
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: _getBaseColorForApp().withOpacity(0.2),
              borderRadius:
                  uniqueShape == AppShape.circle
                      ? null
                      : BorderRadius.circular(
                        uniqueShape == AppShape.hexagon ? 15 : 20,
                      ),
              shape:
                  uniqueShape == AppShape.circle
                      ? BoxShape.circle
                      : BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: _getBaseColorForApp().withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),

          // Main app container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getGradientColorsForApp(),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  uniqueShape == AppShape.circle
                      ? null
                      : BorderRadius.circular(
                        uniqueShape == AppShape.hexagon ? 15 : 20,
                      ),
              shape:
                  uniqueShape == AppShape.circle
                      ? BoxShape.circle
                      : BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with dynamic rotation or animation effect
                Transform.rotate(
                  angle: uniqueShape == AppShape.hexagon ? 0.1 : 0,
                  child: Icon(icon, size: 36, color: Colors.white),
                ),
                const SizedBox(height: 8),
                // Label with custom styling
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Overlay effect
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius:
                    uniqueShape != AppShape.circle
                        ? BorderRadius.only(
                          topLeft: Radius.circular(
                            uniqueShape == AppShape.hexagon ? 15 : 20,
                          ),
                          topRight: Radius.circular(
                            uniqueShape == AppShape.hexagon ? 15 : 20,
                          ),
                        )
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppShape _getUniqueShapeForApp() {
    final hash = label.hashCode % 3;
    switch (hash) {
      case 0:
        return AppShape.rounded;
      case 1:
        return AppShape.hexagon;
      case 2:
        return AppShape.circle;
      default:
        return AppShape.rounded;
    }
  }

  Color _getBaseColorForApp() {
    final hash = label.hashCode % 6;
    switch (hash) {
      case 0:
        return Colors.purple;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.teal;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.pink;
      case 5:
        return Colors.indigo;
      default:
        return Colors.deepPurple;
    }
  }

  List<Color> _getGradientColorsForApp() {
    final baseColor = _getBaseColorForApp();
    return [
      baseColor,
      baseColor
          .withBlue((baseColor.blue + 40) % 255)
          .withRed((baseColor.red + 20) % 255),
    ];
  }
}

enum AppShape { rounded, hexagon, circle }
