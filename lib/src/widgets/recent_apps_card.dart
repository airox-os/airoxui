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
        // The card containing app icons with proper padding
        Container(
          width: MediaQuery.of(context).size.width * 0.5, // Half screen width
          padding: const EdgeInsets.all(16), // Increased padding
          margin: const EdgeInsets.all(8), // Added margin around the card
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                recentApps.map((app) => _buildAppIcon(context, app)).toList(),
          ),
        ),

        // Title below the card with more spacing
        const Padding(
          padding: EdgeInsets.only(top: 12), // Increased padding
          child: Text(
            "Recent Apps",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppIcon(BuildContext context, RecentAppItem app) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ), // Added padding between icons
      child: InkWell(
        onTap: app.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: app.color.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: app.color.withOpacity(0.5),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(app.icon, color: Colors.white, size: 24),
            ),
          ],
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
