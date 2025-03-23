import 'package:flutter/material.dart';
import '../utils/grid_delegates.dart';
import '../widgets/recent_apps_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/weather_card.dart'; // Add this import

class MobileHomeLayout extends StatelessWidget {
  final int selectedIndex;

  const MobileHomeLayout({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    // Show different content based on the selected index
    if (selectedIndex == 1) {
      return _buildSimpleAppsGrid(context);
    }

    // Define the list of app icons for the left grid
    final appIcons = [
      RecentAppItem(
        name: 'Notes',
        icon: Icons.text_snippet,
        color: Colors.amber,
        onTap: () => Navigator.pushNamed(context, '/notes'),
      ),
      RecentAppItem(
        name: 'Camera',
        icon: Icons.camera_alt,
        color: Colors.cyan.shade700,
        onTap: () => Navigator.pushNamed(context, '/camera'),
      ),
      RecentAppItem(
        name: 'Weather',
        icon: Icons.wb_sunny,
        color: Colors.blue.shade700,
        onTap: () => Navigator.pushNamed(context, '/weather'),
      ),
      RecentAppItem(
        name: 'Calendar',
        icon: Icons.calendar_today,
        color: Colors.red.shade700,
        onTap: () => Navigator.pushNamed(context, '/calendar'),
      ),
    ];

    // Define the list of recent apps for the right card
    final recentApps = [
      RecentAppItem(
        name: 'Terminal',
        icon: Icons.terminal,
        color: Colors.deepPurple,
        onTap: () => Navigator.pushNamed(context, '/terminal'),
      ),
      RecentAppItem(
        name: 'Photos',
        icon: Icons.photo,
        color: Colors.teal,
        onTap: () => Navigator.pushNamed(context, '/photos'),
      ),
      RecentAppItem(
        name: 'Files',
        icon: Icons.folder,
        color: Colors.green,
        onTap: () => Navigator.pushNamed(context, '/files'),
      ),
    ];

    // Get screen dimensions for proper positioning
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate heights for various UI sections
    final clockHeight = 130.0; // Clock widget height
    final searchBarHeight = 60.0; // Search bar height with margins
    final topSafeZone =
        clockHeight + searchBarHeight + 30.0; // Additional padding

    // Calculate bottom safe zone
    final dockTotalHeight = 72.0 + 2.0 + 20.0;
    final safetyMargin = 24.0;
    final navigationHandleHeight = 20.0;
    final bottomSafeZone =
        dockTotalHeight + safetyMargin + navigationHandleHeight;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Main content with clock and search bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Clock widget
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _getCurrentTime(),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getCurrentDate(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Search bar below the clock with clear spacing
                const SizedBox(height: 20),
                const CustomSearchBar(),
              ],
            ),
          ),
        ),

        // Organized grid of app icons on the left side
        Positioned(
          top: topSafeZone + 20, // Below search bar with padding
          left: 20, // Left margin
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title for the grid
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 12),
                child: Text(
                  "Apps",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),

              // 2x2 Grid of app icons
              _buildAppIconGrid(context, appIcons),
            ],
          ),
        ),

        // Recent apps section on the right end
        Positioned(
          top: topSafeZone + 20, // Same vertical alignment as the left grid
          right: 20, // Right margin
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Title for recent apps
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 12),
                child: Text(
                  "Recent",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),

              // Vertical list of recent apps
              _buildRecentAppsColumn(context, recentApps),
            ],
          ),
        ),

        // Weather card positioned at the bottom
        Positioned(
          bottom: bottomSafeZone, // Position above the dock with some margin
          left: 0,
          right: 128,
          child: Center(
            child: WeatherCard(
              temperature: 24.5,
              condition: 'Cloudy',
              location: 'Current Location',
            ),
          ),
        ),
      ],
    );
  }

  // Build a 2x2 grid of app icons
  Widget _buildAppIconGrid(BuildContext context, List<RecentAppItem> apps) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First row
        Row(
          children: [
            _buildGridAppIcon(context, apps[0]),
            const SizedBox(width: 16),
            _buildGridAppIcon(context, apps[1]),
          ],
        ),
        const SizedBox(height: 16),
        // Second row
        Row(
          children: [
            _buildGridAppIcon(context, apps[2]),
            const SizedBox(width: 16),
            _buildGridAppIcon(context, apps[3]),
          ],
        ),
      ],
    );
  }

  // Build a vertical column of recent apps
  Widget _buildRecentAppsColumn(
    BuildContext context,
    List<RecentAppItem> apps,
  ) {
    return Container(
      width: 80, // Fixed width
      padding: const EdgeInsets.all(12),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: apps.map((app) => _buildRecentAppItem(context, app)).toList(),
      ),
    );
  }

  Widget _buildGridAppIcon(BuildContext context, RecentAppItem app) {
    return SizedBox(
      width: 70, // Fixed width for consistent grid
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [app.color, app.color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: app.color.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: app.onTap,
                borderRadius: BorderRadius.circular(15),
                child: Icon(app.icon, color: Colors.white, size: 30),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            app.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAppItem(BuildContext context, RecentAppItem app) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
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
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: app.onTap,
                borderRadius: BorderRadius.circular(12),
                child: Icon(app.icon, color: Colors.white, size: 24),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            app.name,
            style: const TextStyle(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleAppButton(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/${label.toLowerCase()}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppIcon(
    BuildContext context, {
    required String name,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.7),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildSimpleAppsGrid(BuildContext context) {
    // A simplified grid for the apps view
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossCountAndFixedHeight(
        crossCount: 4,
        height: 100,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final appsList = [
          {'name': 'Browser', 'icon': Icons.web},
          {'name': 'Editor', 'icon': Icons.text_snippet},
          {'name': 'Terminal', 'icon': Icons.terminal},
          {'name': 'Files', 'icon': Icons.folder},
          {'name': 'Calculator', 'icon': Icons.calculate},
          {'name': 'Settings', 'icon': Icons.settings},
          {'name': 'Photos', 'icon': Icons.photo},
          {'name': 'Music', 'icon': Icons.music_note},
          {'name': 'Camera', 'icon': Icons.camera_alt},
          {'name': 'Mail', 'icon': Icons.mail},
          {'name': 'Calendar', 'icon': Icons.calendar_today},
          {'name': 'Notes', 'icon': Icons.note},
        ];

        final app = appsList[index];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              child: Icon(
                app['icon'] as IconData,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              app['name'] as String,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  Widget _buildScatteredAppIcon(
    BuildContext context, {
    required String name,
    required Color color,
    required IconData icon,
  }) {
    // Fixed size container to prevent overflow
    return SizedBox(
      width: 70, // Slightly wider to accommodate the label
      height: 90, // Taller to allow for icon + text + padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(
            height: 6,
          ), // Slightly more spacing between icon and label
          Container(
            width: 70, // Ensure the label container has fixed width
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 10),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalRecentAppsCard(
    BuildContext context,
    List<RecentAppItem> recentApps,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title above the card
        Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Recent Apps",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        // Vertical card with app icons
        Container(
          width: 70, // Narrow width for vertical layout
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                recentApps
                    .map((app) => _buildVerticalAppIcon(context, app))
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalAppIcon(BuildContext context, RecentAppItem app) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: app.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 50,
          height: 50,
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
      ),
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }
}
