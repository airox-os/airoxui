import 'package:flutter/material.dart';

class DesktopHomeLayout extends StatefulWidget {
  final int selectedIndex;

  const DesktopHomeLayout({super.key, required this.selectedIndex});

  @override
  State<DesktopHomeLayout> createState() => _DesktopHomeLayoutState();
}

class _DesktopHomeLayoutState extends State<DesktopHomeLayout> {
  // List to store folder positions
  final List<FolderData> _folders = [
    FolderData(
      title: 'Documents',
      icon: Icons.folder,
      color: Colors.deepPurple.shade300,
      position: const Offset(50, 80),
    ),
    FolderData(
      title: 'Media',
      icon: Icons.folder_special,
      color: Colors.purple.shade400,
      position: const Offset(50, 180),
    ),
    FolderData(
      title: 'Downloads',
      icon: Icons.download,
      color: Colors.purpleAccent.shade200,
      position: const Offset(50, 280),
    ),
    FolderData(
      title: 'Trash',
      icon: Icons.delete,
      color: Colors.deepPurple.shade400,
      position: const Offset(50, 380),
      isTrash: true,
    ),
  ];

  // Track which folder is being dragged
  int? _draggedFolderIndex;
  bool _isDragging = false;

  // Method to get the current time as a formatted string
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  // Method to get the current date as a formatted string
  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Central interactive element
        Center(child: _buildImmersiveClockWidget(context)),

        // Desktop folder icons with draggable behavior
        ..._folders.asMap().entries.map((entry) {
          final index = entry.key;
          final folder = entry.value;

          return Positioned(
            left: folder.position.dx,
            top: folder.position.dy,
            child: _buildDraggableFolder(folder, index),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDraggableFolder(FolderData folder, int index) {
    return GestureDetector(
      // Handle long press to start dragging
      onLongPress: () {
        setState(() {
          _draggedFolderIndex = index;
          _isDragging = true;
        });
      },

      // Handle drag updates
      onPanUpdate: (details) {
        if (_draggedFolderIndex == index) {
          setState(() {
            _folders[index] = _folders[index].copyWith(
              position: Offset(
                _folders[index].position.dx + details.delta.dx,
                _folders[index].position.dy + details.delta.dy,
              ),
            );
          });
        }
      },

      // Handle drag end
      onPanEnd: (details) {
        setState(() {
          _draggedFolderIndex = null;
          _isDragging = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform:
            _draggedFolderIndex == index
                ? (Matrix4.identity()..scale(1.1)) // Scale up when dragging
                : Matrix4.identity(),
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
                    color: folder.color.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          _draggedFolderIndex == index ? 0.5 : 0.3,
                        ),
                        blurRadius: _draggedFolderIndex == index ? 12 : 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(
                        _draggedFolderIndex == index ? 0.5 : 0.3,
                      ),
                      width: _draggedFolderIndex == index ? 2 : 1,
                    ),
                  ),
                  child: Icon(folder.icon, color: Colors.white, size: 30),
                ),

                // Trash overlay (50% opaque trash icon)
                if (folder.isTrash)
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
                color: Colors.black.withOpacity(
                  _draggedFolderIndex == index ? 0.6 : 0.4,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                folder.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight:
                      _draggedFolderIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
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
}

// Data class to hold folder information and position
class FolderData {
  final String title;
  final IconData icon;
  final Color color;
  final Offset position;
  final bool isTrash;

  const FolderData({
    required this.title,
    required this.icon,
    required this.color,
    required this.position,
    this.isTrash = false,
  });

  // Helper method to create a copy with updated position
  FolderData copyWith({
    String? title,
    IconData? icon,
    Color? color,
    Offset? position,
    bool? isTrash,
  }) {
    return FolderData(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      position: position ?? this.position,
      isTrash: isTrash ?? this.isTrash,
    );
  }
}
