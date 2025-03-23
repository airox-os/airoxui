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
      return _buildInnovativeAppsGrid(context);
    }

    // Default home view with radically different design
    return Stack(
      children: [
        // Dynamic background particles or effects could be added here

        // Main scrollable content
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Futuristic clock module
              _buildFuturisticClockModule(context),
              const SizedBox(height: 30),

              // Interactive app modules - not just rectangles!
              _buildInteractiveModules(context),

              // Bottom padding to avoid overlap with dock
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFuturisticClockModule(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigoAccent.withOpacity(0.7),
              Colors.purpleAccent.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.purpleAccent.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
        ),
        child: Column(
          children: [
            // Unique digital display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  _getCurrentTime().split('').map((char) {
                    bool isColon = char == ':';
                    return Container(
                      width: isColon ? 15 : 35,
                      height: isColon ? 40 : 60,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isColon ? Colors.transparent : Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            isColon
                                ? null
                                : Border.all(color: Colors.white24, width: 1),
                      ),
                      child: Text(
                        char,
                        style: TextStyle(
                          fontSize: isColon ? 40 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 15),
            // Unique date display with pulsing indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.6),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  _getCurrentDate(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveModules(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading with unique styling
        Container(
          margin: const EdgeInsets.only(left: 5, bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: const Text(
            'MODULES',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),

        // Grid of modules with different shapes and sizes
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.95,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildDynamicModuleTile(
              context,
              title: 'Creative',
              icon: Icons.brush,
              color: Colors.deepPurple,
              apps: [
                {'icon': Icons.text_snippet, 'label': 'Editor'},
                {'icon': Icons.photo, 'label': 'Photos'},
              ],
            ),
            _buildDynamicModuleTile(
              context,
              title: 'Tools',
              icon: Icons.build,
              color: Colors.teal,
              apps: [
                {'icon': Icons.calculate, 'label': 'Calculator'},
                {'icon': Icons.folder, 'label': 'Files'},
              ],
            ),
            _buildDynamicModuleTile(
              context,
              title: 'System',
              icon: Icons.computer,
              color: Colors.indigo,
              apps: [
                {'icon': Icons.terminal, 'label': 'Terminal'},
                {'icon': Icons.settings, 'label': 'Settings'},
              ],
            ),
            _buildDynamicModuleTile(
              context,
              title: 'Media',
              icon: Icons.play_circle,
              color: Colors.deepOrange,
              apps: [
                {'icon': Icons.music_note, 'label': 'Music'},
                {'icon': Icons.web, 'label': 'Browser'},
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDynamicModuleTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<Map<String, dynamic>> apps,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.7),
            color.withRed((color.red + 40) % 255).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            top: -20,
            right: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(icon, size: 100, color: Colors.white),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, size: 20, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    children:
                        apps.map((app) {
                          return InkWell(
                            onTap:
                                () => Navigator.pushNamed(
                                  context,
                                  '/${app['label'].toLowerCase()}',
                                ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    app['icon'] as IconData,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    app['label'] as String,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInnovativeAppsGrid(BuildContext context) {
    // Apps presented in a unique, non-grid layout
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.apps, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Applications',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Category sections
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildStaggeredAppsSection(context),
          ),
        ),
      ],
    );
  }

  Widget _buildStaggeredAppsSection(BuildContext context) {
    // A more creative way to display apps than a standard grid
    final apps = [
      {'icon': Icons.web, 'name': 'Browser', 'color': Colors.blue},
      {'icon': Icons.text_snippet, 'name': 'Editor', 'color': Colors.indigo},
      {'icon': Icons.terminal, 'name': 'Terminal', 'color': Colors.blueGrey},
      {'icon': Icons.folder, 'name': 'Files', 'color': Colors.amber},
      {'icon': Icons.calculate, 'name': 'Calculator', 'color': Colors.pink},
      {'icon': Icons.settings, 'name': 'Settings', 'color': Colors.teal},
      {'icon': Icons.mail, 'name': 'Mail', 'color': Colors.red},
      {'icon': Icons.calendar_today, 'name': 'Calendar', 'color': Colors.green},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          apps.asMap().entries.map((entry) {
            final index = entry.key;
            final app = entry.value;

            // Different sizes for different apps
            final isLarge = index % 5 == 0;
            final size = isLarge ? 120.0 : 85.0;

            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (app['color'] as Color).withOpacity(0.7),
                    (app['color'] as Color)
                        .withBlue(((app['color'] as Color).blue + 30) % 255)
                        .withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(isLarge ? 24 : 16),
                boxShadow: [
                  BoxShadow(
                    color: (app['color'] as Color).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: InkWell(
                onTap:
                    () => Navigator.pushNamed(
                      context,
                      '/${(app['name'] as String).toLowerCase()}',
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      app['icon'] as IconData,
                      size: isLarge ? 40 : 30,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      app['name'] as String,
                      style: TextStyle(
                        fontSize: isLarge ? 16 : 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
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

class _DesktopHomeLayout extends StatelessWidget {
  final int selectedIndex;

  const _DesktopHomeLayout({required this.selectedIndex});

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
    // Create a more futuristic lock screen
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < -100) {
          onUnlock();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          // A more dynamic background
          gradient: LinearGradient(
            colors: [
              Colors.indigo.withOpacity(0.9),
              Colors.deepPurple.withOpacity(0.7),
              Colors.black.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Background design elements
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/desktop/pattern.png', // You would need to add this asset
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Time display
                  Text(
                    DateTime.now().hour.toString().padLeft(2, '0') +
                        ':' +
                        DateTime.now().minute.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: isMobile ? 60 : 80,
                      fontWeight: FontWeight.w200,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),

                  Text(
                    'Swipe up to unlock',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: isMobile ? 16 : 20,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: isMobile ? 40 : 60),

                  // Fingerprint animation
                  AnimatedBuilder(
                    animation: fingerprintAnimation,
                    builder: (context, child) {
                      return Container(
                        width: isMobile ? 100 : 140,
                        height: isMobile ? 100 : 140,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(
                              0.2 + (0.3 * fingerprintAnimation.value),
                            ),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(
                                0.1 * fingerprintAnimation.value,
                              ),
                              blurRadius: 20,
                              spreadRadius: 5 * fingerprintAnimation.value,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.fingerprint,
                          size: isMobile ? 60 : 80,
                          color: Colors.white.withOpacity(
                            0.8 + (0.2 * fingerprintAnimation.value),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'AIROX OS',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
