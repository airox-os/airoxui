import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/adaptive_layout.dart';
import '../widgets/app_tile.dart';
import '../widgets/system_status_bar.dart';
import '../widgets/dock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isLocked = true;
  late AnimationController _fingerprintController;

  @override
  void initState() {
    super.initState();
    _fingerprintController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Hide system status bar on all platforms - we'll be showing our own on desktop
    _hideSystemUI();
  }

  // Set up full screen mode
  void _hideSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore system UI when the widget is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _fingerprintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              isMobile
                  ? 'assets/desktop/mobile.png'
                  : 'assets/desktop/desktop.png',
              fit: BoxFit.cover,
            ),
          ),
          // Home screen content
          Column(
            children: [
              // Show SystemStatusBar on both mobile and desktop
              const SystemStatusBar(),
              Expanded(
                child: AdaptiveLayout(
                  mobile: _MobileHomeLayout(selectedIndex: _selectedIndex),
                  desktop: _DesktopHomeLayout(selectedIndex: _selectedIndex),
                ),
              ),
              if (!isMobile)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Dock(items: _dockItems, isMobile: false),
                ),
            ],
          ),
          // Lock screen overlay
          if (_isLocked)
            Positioned.fill(
              child: _LockScreen(
                isMobile: isMobile,
                fingerprintAnimation: _fingerprintController,
                onUnlock: () {
                  setState(() {
                    _isLocked = false;
                  });
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar:
          isMobile && !_isLocked
              ? Dock(
                items: _dockItems,
                isMobile: true,
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              )
              : null,
    );
  }

  List<DockItem> get _dockItems => [
    DockItem(
      icon: Icons.photo,
      label: 'Photos',
      onTap: () => Navigator.pushNamed(context, '/photos'),
    ),
    DockItem(
      icon: Icons.terminal,
      label: 'Terminal',
      onTap: () => Navigator.pushNamed(context, '/terminal'),
    ),
    DockItem(
      icon: Icons.apps,
      label: 'Apps',
      onTap: () {
        setState(() {
          _selectedIndex = 1;
        });
      },
    ),
    DockItem(
      icon: Icons.calculate,
      label: 'Calculator',
      onTap: () => Navigator.pushNamed(context, '/calculator'),
    ),
    DockItem(
      icon: Icons.settings,
      label: 'Settings',
      onTap: () => Navigator.pushNamed(context, '/settings'),
    ),
  ];
}

class _MobileHomeLayout extends StatelessWidget {
  final int selectedIndex;

  const _MobileHomeLayout({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    // Show different content based on the selected index
    if (selectedIndex == 1) {
      return _buildAppsGrid(context);
    }

    // Default home view with clock and app groups
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Centralized digital clock with date
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.withOpacity(0.6),
                    Colors.indigo.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
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
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getCurrentDate(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Widget tiles containing clumps of apps - fixed height to prevent overflow
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.0, // Fixed aspect ratio
            children: [
              _buildAppClumpTile(
                context,
                title: 'Productivity',
                apps: [
                  {'icon': Icons.text_snippet, 'label': 'Editor'},
                  {'icon': Icons.calculate, 'label': 'Calculator'},
                ],
              ),
              _buildAppClumpTile(
                context,
                title: 'Media',
                apps: [
                  {'icon': Icons.photo, 'label': 'Photos'},
                  {'icon': Icons.music_note, 'label': 'Music'},
                ],
              ),
              _buildAppClumpTile(
                context,
                title: 'System',
                apps: [
                  {'icon': Icons.terminal, 'label': 'Terminal'},
                  {'icon': Icons.settings, 'label': 'Settings'},
                ],
              ),
              _buildAppClumpTile(
                context,
                title: 'Utilities',
                apps: [
                  {'icon': Icons.folder, 'label': 'Files'},
                  {'icon': Icons.web, 'label': 'Browser'},
                ],
              ),
            ],
          ),
          // Add bottom padding to avoid overlap with dock
          const SizedBox(height: 16),
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

  Widget _buildAppClumpTile(
    BuildContext context, {
    required String title,
    required List<Map<String, dynamic>> apps,
  }) {
    // Create a colorful background based on the title
    final colorIndex = title.hashCode % 4;
    final gradientColors = _getGradientColorsForIndex(colorIndex);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children:
                      apps.map((app) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(app['icon']),
                              iconSize: 30,
                              onPressed:
                                  () => Navigator.pushNamed(
                                    context,
                                    '/${app['label'].toLowerCase()}',
                                  ),
                            ),
                            Text(
                              app['label'],
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColorsForIndex(int index) {
    switch (index) {
      case 0:
        return [Colors.teal.withOpacity(0.7), Colors.cyan.withOpacity(0.7)];
      case 1:
        return [Colors.pink.withOpacity(0.7), Colors.purple.withOpacity(0.7)];
      case 2:
        return [Colors.orange.withOpacity(0.7), Colors.amber.withOpacity(0.7)];
      case 3:
      default:
        return [Colors.blue.withOpacity(0.7), Colors.indigo.withOpacity(0.7)];
    }
  }

  Widget _buildAppsGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.75,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: 16, // Example number of apps
        itemBuilder: (context, index) {
          // Example app item
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.apps),
                iconSize: 48,
                onPressed: () {},
              ),
              Text(
                'App $index',
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DesktopHomeLayout extends StatelessWidget {
  final int selectedIndex;

  const _DesktopHomeLayout({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.withOpacity(0.6),
              Colors.cyan.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centralized digital clock with date
            Text(
              _getCurrentTime(),
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              _getCurrentDate(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
          ],
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

class _LockScreen extends StatelessWidget {
  final bool isMobile;
  final AnimationController fingerprintAnimation;
  final VoidCallback onUnlock;

  const _LockScreen({
    required this.isMobile,
    required this.fingerprintAnimation,
    required this.onUnlock,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < -100) {
          onUnlock();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Swipe up to unlock',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: isMobile ? 18 : 24,
              ),
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
              animation: fingerprintAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + 0.1 * fingerprintAnimation.value,
                  child: child,
                );
              },
              child: Icon(
                Icons.fingerprint,
                size: isMobile ? 80 : 120,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Airox OS',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
