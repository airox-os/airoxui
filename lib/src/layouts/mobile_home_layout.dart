import 'package:flutter/material.dart';
import '../utils/grid_delegates.dart';

class MobileHomeLayout extends StatelessWidget {
  final int selectedIndex;

  const MobileHomeLayout({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    // Show different content based on the selected index
    if (selectedIndex == 1) {
      return _buildSimpleAppsGrid(context);
    }

    // Simplified home view with just the clock, creative module, and 3 app icons
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simple digital clock
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Creative module (simplified)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.brush, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Creative',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSimpleAppButton(
                      context,
                      icon: Icons.text_snippet,
                      label: 'Editor',
                    ),
                    _buildSimpleAppButton(
                      context,
                      icon: Icons.photo,
                      label: 'Photos',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Just 3 simple app icons (no fancy effects)
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'Featured Apps',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAppIcon(
                context,
                name: 'Photos',
                color: Colors.teal,
                icon: Icons.camera,
              ),
              _buildAppIcon(
                context,
                name: 'Vexeroo',
                color: Colors.deepOrange,
                icon: Icons.auto_awesome,
              ),
              _buildAppIcon(
                context,
                name: 'DeepSensor',
                color: Colors.indigo,
                icon: Icons.analytics,
              ),
            ],
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
