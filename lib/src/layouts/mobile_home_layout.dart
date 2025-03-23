import 'package:flutter/material.dart';
import '../utils/grid_delegates.dart';
import '../widgets/recent_apps_card.dart';
import '../widgets/search_bar.dart';

class MobileHomeLayout extends StatelessWidget {
  final int selectedIndex;

  const MobileHomeLayout({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    // Show different content based on the selected index
    if (selectedIndex == 1) {
      return _buildSimpleAppsGrid(context);
    }

    // Define the list of recent apps
    final recentApps = [
      RecentAppItem(
        name: 'Notes',
        icon: Icons.text_snippet,
        color: Colors.amber,
        onTap: () => Navigator.pushNamed(context, '/notes'),
      ),
      RecentAppItem(
        name: 'Photos',
        icon: Icons.photo,
        color: Colors.teal,
        onTap: () => Navigator.pushNamed(context, '/photos'),
      ),
      RecentAppItem(
        name: 'Calculator',
        icon: Icons.calculate,
        color: Colors.orange,
        onTap: () => Navigator.pushNamed(context, '/calculator'),
      ),
      RecentAppItem(
        name: 'Terminal',
        icon: Icons.terminal,
        color: Colors.deepPurple,
        onTap: () => Navigator.pushNamed(context, '/terminal'),
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

    // Calculate available height for app icons
    final availableHeight = screenHeight - topSafeZone - bottomSafeZone;

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

        // App icons with precise positioning - ONLY THREE ICONS NOW (removed Calculator)
        // Left side (Weather)
        Positioned(
          top: topSafeZone + 40, // Well below search bar
          left: screenWidth * 0.25,
          child: _buildScatteredAppIcon(
            context,
            name: 'Weather',
            color: Colors.blue.shade700,
            icon: Icons.wb_sunny,
          ),
        ),

        // Right side (Camera)
        Positioned(
          top: topSafeZone + 40, // Well below search bar
          right: screenWidth * 0.25,
          child: _buildScatteredAppIcon(
            context,
            name: 'Camera',
            color: Colors.cyan.shade700,
            icon: Icons.camera_alt,
          ),
        ),

        // Center (Calendar) - positioned between the top icons and recent apps
        Positioned(
          top:
              topSafeZone +
              (availableHeight * 0.5), // Center in available space
          left: 0,
          right: 0,
          child: Center(
            child: _buildScatteredAppIcon(
              context,
              name: 'Calendar',
              color: Colors.red.shade700,
              icon: Icons.calendar_today,
            ),
          ),
        ),

        // Recent apps card positioned at the rightmost end of the screen
        Positioned(
          right: 24, // Right margin from screen edge
          bottom: bottomSafeZone, // Same bottom position as before
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [_buildVerticalRecentAppsCard(context, recentApps)],
          ),
        ),
      ],
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

  Widget _buildRecentAppItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/${label.toLowerCase()}'),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
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
