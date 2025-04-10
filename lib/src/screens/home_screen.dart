import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/adaptive_layout.dart';
import '../widgets/dock.dart';
import '../widgets/system_status_bar.dart';
import '../widgets/lock_screen.dart';
import '../widgets/navigation_handle.dart'; // Import the navigation handle
import '../layouts/mobile_home_layout.dart';
import '../layouts/desktop_home_layout.dart';

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

              // Main content area
              Expanded(
                child: AdaptiveLayout(
                  mobile: MobileHomeLayout(selectedIndex: _selectedIndex),
                  desktop: DesktopHomeLayout(selectedIndex: _selectedIndex),
                ),
              ),

              // Desktop dock at the bottom (only for desktop)
              if (!isMobile)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Dock(items: _dockItems, isMobile: false),
                  ),
                ),
            ],
          ),

          // Mobile dock at the bottom (only for mobile)
          if (isMobile && !_isLocked)
            Positioned(
              left: 0,
              right: 0,
              bottom: 20, // Position above the navigation handle
              child: Dock(
                items: _dockItems,
                isMobile: true,
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                  setState(() {
                    if (index == 2) {
                      _selectedIndex = 1;
                    }
                  });
                },
              ),
            ),

          // Navigation handle (only for mobile)
          if (isMobile && !_isLocked)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: NavigationHandle(
                  width: 160,
                  color: Colors.white,
                  height: 6,
                  onTap: () {
                    // Handle the navigation gesture
                  },
                ),
              ),
            ),

          // Lock screen overlay
          if (_isLocked)
            Positioned.fill(
              child: LockScreen(
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
    );
  }

  List<DockItem> get _dockItems => [
    DockItem(
      icon: Icons.photo,
      label: 'Photos',
      backgroundColor: Colors.teal, // Add unique background color
      onTap: () => Navigator.pushNamed(context, '/photos'),
    ),
    DockItem(
      icon: Icons.terminal,
      label: 'Terminal',
      backgroundColor: Colors.deepPurple, // Add unique background color
      onTap: () => Navigator.pushNamed(context, '/terminal'),
    ),
    DockItem(
      icon: Icons.apps,
      label: 'Apps',
      backgroundColor: Colors.blue, // Add unique background color
      onTap: () {
        setState(() {
          _selectedIndex = 1;
        });
      },
    ),
    DockItem(
      icon: Icons.calculate,
      label: 'Calculator',
      backgroundColor: Colors.orange, // Add unique background color
      onTap: () => Navigator.pushNamed(context, '/calculator'),
    ),
    DockItem(
      icon: Icons.settings,
      label: 'Settings',
      backgroundColor: Colors.green, // Add unique background color
      onTap: () => Navigator.pushNamed(context, '/settings'),
    ),
  ];
}
