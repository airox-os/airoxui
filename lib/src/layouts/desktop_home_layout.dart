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

        // Desktop folder icons scattered around
        Positioned(
          left: 50,
          top: 80,
          child: _buildDesktopFolder(
            title: 'Documents',
            icon: Icons.folder,
            color: Colors.deepPurple.shade300,
          ),
        ),

        Positioned(
          left: 50,
          top: 180,
          child: _buildDesktopFolder(
            title: 'Media',
            icon: Icons.folder_special,
            color: Colors.purple.shade400,
          ),
        ),

        Positioned(
          left: 50,
          top: 280,
          child: _buildDesktopFolder(
            title: 'Downloads',
            icon: Icons.download,
            color: Colors.purpleAccent.shade200,
          ),
        ),

        Positioned(
          right: 50,
          top: 80,
          child: _buildDesktopFolder(
            title: 'Trash',
            icon: Icons.delete,
            color: Colors.deepPurple.shade400,
            isTrash: true, // Special case for trash folder
          ),
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

  Widget _buildDesktopFolder({
    required String title,
    required IconData icon,
    required Color color,
    bool isTrash = false,
  }) {
    return InkWell(
      onTap: () {
        // Handle folder tap
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Folder background
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(icon, color: Colors.white, size: 30),
              ),

              // Trash overlay (50% opaque trash icon)
              if (isTrash)
                Icon(
                  Icons.delete,
                  size: 24,
                  color: Colors.white.withOpacity(0.5),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
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
