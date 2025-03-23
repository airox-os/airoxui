import 'package:flutter/material.dart';

/// Utility class for providing consistent 3D styling across the UI
class AiroxUIStyling {
  /// Creates elevated container decoration with 3D appearance
  static BoxDecoration elevatedContainer({
    required Color baseColor,
    double borderRadius = 20.0,
    bool useGradient = true,
    Alignment gradientBegin = Alignment.topLeft,
    Alignment gradientEnd = Alignment.bottomRight,
  }) {
    return BoxDecoration(
      gradient:
          useGradient
              ? LinearGradient(
                begin: gradientBegin,
                end: gradientEnd,
                colors: [
                  baseColor.withOpacity(0.9),
                  baseColor.withOpacity(0.6),
                ],
              )
              : null,
      color: useGradient ? null : baseColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      boxShadow: [
        // Main shadow for depth
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 15,
          spreadRadius: 2,
          offset: const Offset(0, 8),
        ),
        // Secondary shadow with base color
        BoxShadow(
          color: baseColor.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 0,
          offset: const Offset(0, 4),
        ),
        // Top highlight for 3D effect
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          blurRadius: 4,
          spreadRadius: 0,
          offset: const Offset(0, -2),
        ),
      ],
    );
  }

  /// Creates icon shadow style for consistent 3D icon appearance
  static List<Shadow> iconShadows({Color? customColor}) {
    final Color shadowColor = customColor ?? Colors.black;
    return [
      Shadow(
        color: shadowColor.withOpacity(0.5),
        blurRadius: 4,
        offset: const Offset(1, 1),
      ),
      Shadow(
        color: shadowColor.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ];
  }

  /// Creates text shadow style for enhanced readability
  static List<Shadow> textShadows({Color? customColor}) {
    final Color shadowColor = customColor ?? Colors.black;
    return [
      Shadow(
        color: shadowColor.withOpacity(0.6),
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
      Shadow(
        color: shadowColor.withOpacity(0.3),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ];
  }

  /// Creates an elevated icon button decoration with 3D effects
  static BoxDecoration elevatedIconButton({
    required Color baseColor,
    double borderRadius = 14.0,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [baseColor.withOpacity(1.0), baseColor.withOpacity(0.7)],
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        // Main shadow matching the button color
        BoxShadow(
          color: baseColor.withOpacity(0.6),
          blurRadius: 10,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
        // Deeper shadow for more depth
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 0,
          offset: const Offset(0, 6),
        ),
        // Top highlight for 3D effect
        BoxShadow(
          color: Colors.white.withOpacity(0.4),
          blurRadius: 4,
          spreadRadius: 0,
          offset: const Offset(0, -1),
        ),
      ],
      // Subtle border for definition
      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
    );
  }

  /// Applies elevated styling to scaffold background with subtle patterns
  static BoxDecoration elevatedScaffoldBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.grey.shade900, Colors.black],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.6),
          blurRadius: 15,
          spreadRadius: 5,
        ),
      ],
    );
  }

  /// Creates card style that offers depth and 3D appearance
  static BoxDecoration elevatedCard({
    required Color baseColor,
    double borderRadius = 24.0,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [baseColor.withOpacity(0.8), baseColor.withOpacity(0.5)],
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        // Deep shadow
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 20,
          spreadRadius: 4,
          offset: const Offset(0, 8),
        ),
        // Secondary shadow
        BoxShadow(
          color: baseColor.withOpacity(0.3),
          blurRadius: 12,
          spreadRadius: 1,
          offset: const Offset(0, 5),
        ),
        // Inner light reflection
        BoxShadow(
          color: Colors.white.withOpacity(0.2),
          blurRadius: 15,
          spreadRadius: -3,
          offset: const Offset(0, -4),
        ),
        // Top edge highlight
        BoxShadow(
          color: Colors.white.withOpacity(0.2),
          blurRadius: 2,
          spreadRadius: 0,
          offset: const Offset(0, -1),
        ),
      ],
      border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
    );
  }

  /// Creates a glassy button effect with 3D appearance
  static BoxDecoration glassButton({
    required Color baseColor,
    double borderRadius = 16.0,
  }) {
    return BoxDecoration(
      color: baseColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.0),
      boxShadow: [
        // Main outer shadow
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
        // Inner highlight
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          blurRadius: 4,
          spreadRadius: -2,
          offset: const Offset(0, -2),
        ),
      ],
    );
  }
}
