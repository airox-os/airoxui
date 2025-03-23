import 'package:flutter/material.dart';
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
  }

  @override
  void dispose() {
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
              ? Padding(
                padding: const EdgeInsets.all(16),
                child: Dock(
                  items: _dockItems,
                  isMobile: true,
                  selectedIndex: _selectedIndex,
                  onItemSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Centralized digital clock with date
        Center(
          child: Column(
            children: [
              Text(
                _getCurrentTime(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getCurrentDate(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Widget tiles containing clumps of apps
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
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
      ],
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  apps.map((app) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(app['icon']),
                          iconSize: 36,
                          onPressed:
                              () => Navigator.pushNamed(
                                context,
                                '/${app['label'].toLowerCase()}',
                              ),
                        ),
                        Text(
                          app['label'],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ],
        ),
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
      child: Column(
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
