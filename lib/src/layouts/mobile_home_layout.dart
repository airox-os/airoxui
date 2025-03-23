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

    // Get screen height for proper positioning
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate position for the recent apps card (above dock but with padding)
    final dockHeight = 72.0 + 20.0; // Dock height + padding
    final recentAppsPosition =
        screenHeight - dockHeight - 100.0; // Position from top

    // Simplified home view with clock, suggestions, and scattered apps
    return Stack(
      children: [
        // Main scrollable content
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simple digital clock
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

                // Search bar below the clock
                const SizedBox(height: 20),
                const CustomSearchBar(),

                // Spacer to push content down and make room for scattered apps
                SizedBox(height: screenHeight * 0.5),
              ],
            ),
          ),
        ),

        // Scattered apps
        // Weather App (top right)
        Positioned(
          top: 100,
          right: 30,
          child: _buildScatteredAppIcon(
            context,
            name: 'Weather',
            color: Colors.blue.shade700,
            icon: Icons.wb_sunny,
          ),
        ),

        // Calendar App (left side)
        Positioned(
          top: 220,
          left: 30,
          child: _buildScatteredAppIcon(
            context,
            name: 'Calendar',
            color: Colors.red.shade700,
            icon: Icons.calendar_today,
          ),
        ),

        // Camera App (center right)
        Positioned(
          top: 220,
          right: 40,
          child: _buildScatteredAppIcon(
            context,
            name: 'Camera',
            color: Colors.cyan.shade700,
            icon: Icons.camera_alt,
          ),
        ),

        // DeepSensor App (center left)
        Positioned(
          top: 350,
          left: 40,
          child: _buildScatteredAppIcon(
            context,
            name: 'DeepSensor',
            color: Colors.indigo.shade700,
            icon: Icons.analytics,
          ),
        ),

        // Recent apps card positioned above the dock
        Positioned(
          left: 0,
          right: 0,
          top: recentAppsPosition,
          child: Center(child: RecentAppsCard(recentApps: recentApps)),
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
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/${name.toLowerCase()}'),
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
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
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
