import 'package:flutter/material.dart';

class DesktopHomeLayout extends StatelessWidget {
  final int selectedIndex;

  const DesktopHomeLayout({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    // An innovative desktop layout that breaks away from traditional desktop metaphors
    return Stack(
      children: [
        // Central interactive element
        Center(child: _buildImmersiveClockWidget(context)),

        // Radial app launcher
        Positioned(
          right: 50,
          bottom: 100,
          child: _buildRadialAppLauncher(context),
        ),
      ],
    );
  }

  Widget _buildImmersiveClockWidget(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.cyan.withOpacity(0.7),
            Colors.blue.withOpacity(0.3),
            Colors.transparent,
          ],
          stops: const [0.4, 0.8, 1.0],
          radius: 0.8,
        ),
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
          ),

          // Middle ring
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
          ),

          // Inner content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getCurrentTime(),
                style: const TextStyle(
                  fontSize: 54,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _getCurrentDate(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.flight_takeoff,
                      size: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'AIROX OS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadialAppLauncher(BuildContext context) {
    final apps = [
      {'icon': Icons.web, 'name': 'Browser'},
      {'icon': Icons.text_snippet, 'name': 'Editor'},
      {'icon': Icons.terminal, 'name': 'Terminal'},
      {'icon': Icons.folder, 'name': 'Files'},
      {'icon': Icons.calculate, 'name': 'Calculator'},
      {'icon': Icons.settings, 'name': 'Settings'},
    ];

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.7),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.apps, color: Colors.white),
        onPressed: () {
          // In a real app, this would trigger the radial menu to appear
          // For this example, we're just showing what it would look like
        },
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
