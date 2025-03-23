import 'package:flutter/material.dart';

class RecentAppsCard extends StatelessWidget {
  final List<RecentAppItem> recentApps;

  const RecentAppsCard({super.key, required this.recentApps});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // The card containing app icons with enhanced 3D effect
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(18), // Increased padding
          margin: const EdgeInsets.all(10), // Added margin around the card
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.withOpacity(0.5),
                Colors.deepPurple.withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              // Main shadow for depth
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
              // Secondary shadow for more depth
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.3),
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
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                recentApps.map((app) => _buildAppIcon(context, app)).toList(),
          ),
        ),

        // Title below the card with enhanced text
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            "Recent Apps",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              shadows: [
                // Adding text shadow for better visibility
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
                Shadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppIcon(BuildContext context, RecentAppItem app) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: app.onTap,
          borderRadius: BorderRadius.circular(14),
          splashColor: app.color.withOpacity(0.3),
          highlightColor: app.color.withOpacity(0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Enhanced container with 3D effect
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      app.color.withOpacity(1.0),
                      app.color.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    // Main shadow
                    BoxShadow(
                      color: app.color.withOpacity(0.6),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                    // Deeper shadow
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
                  // Subtle border
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  app.icon,
                  color: Colors.white,
                  size: 26,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                    ),
                    Shadow(
                      color: app.color.withOpacity(0.8),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),

              // Optional: Add app name with shadows
              const SizedBox(height: 5),
              Text(
                app.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentAppItem {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const RecentAppItem({
    required this.name,
    required this.icon,
    required this.color,
    this.onTap,
  });
}
