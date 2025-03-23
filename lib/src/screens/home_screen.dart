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

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Airox OS',
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
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
          // Foreground content
          Column(
            children: [
              const SystemStatusBar(),
              Expanded(
                child: AdaptiveLayout(
                  mobile: _MobileHomeLayout(selectedIndex: _selectedIndex),
                  desktop: _DesktopHomeLayout(selectedIndex: _selectedIndex),
                ),
              ),
              if (!isMobile) Dock(items: _dockItems, isMobile: false),
            ],
          ),
        ],
      ),
      bottomNavigationBar:
          isMobile
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
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
      onTap: () {
        setState(() {
          _selectedIndex = 0;
        });
      },
    ),
    DockItem(
      icon: Icons.apps_outlined,
      selectedIcon: Icons.apps,
      label: 'Applications',
      onTap: () {
        setState(() {
          _selectedIndex = 1;
        });
      },
    ),
    DockItem(
      icon: Icons.folder_outlined,
      selectedIcon: Icons.folder,
      label: 'Files',
      onTap: () => Navigator.pushNamed(context, '/files'),
    ),
    DockItem(
      icon: Icons.terminal,
      label: 'Terminal',
      onTap: () => Navigator.pushNamed(context, '/terminal'),
    ),
    DockItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
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

    // Default home view
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Applications',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            AppTile(
              icon: Icons.web,
              label: 'Browser',
              onTap: () => Navigator.pushNamed(context, '/browser'),
            ),
            AppTile(
              icon: Icons.text_snippet,
              label: 'Editor',
              onTap: () => Navigator.pushNamed(context, '/editor'),
            ),
            AppTile(
              icon: Icons.terminal,
              label: 'Terminal',
              onTap: () => Navigator.pushNamed(context, '/terminal'),
            ),
            AppTile(
              icon: Icons.folder,
              label: 'Files',
              onTap: () => Navigator.pushNamed(context, '/files'),
            ),
            AppTile(
              icon: Icons.calculate,
              label: 'Calculator',
              onTap: () => Navigator.pushNamed(context, '/calculator'),
            ),
            AppTile(
              icon: Icons.settings,
              label: 'Settings',
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'System',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'System Information',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text('Airox OS v1.0.0'),
                const SizedBox(height: 4),
                const Text('Build: Development'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppsGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: 16, // Example number of apps
      itemBuilder: (context, index) {
        // Just showing some sample apps - in a real OS you'd have a proper app list
        final apps = [
          {'icon': Icons.web, 'name': 'Browser'},
          {'icon': Icons.text_snippet, 'name': 'Editor'},
          {'icon': Icons.terminal, 'name': 'Terminal'},
          {'icon': Icons.folder, 'name': 'Files'},
          {'icon': Icons.calculate, 'name': 'Calculator'},
          {'icon': Icons.settings, 'name': 'Settings'},
          {'icon': Icons.mail, 'name': 'Mail'},
          {'icon': Icons.calendar_today, 'name': 'Calendar'},
          {'icon': Icons.message, 'name': 'Messages'},
          {'icon': Icons.music_note, 'name': 'Music'},
          {'icon': Icons.photo, 'name': 'Photos'},
          {'icon': Icons.video_library, 'name': 'Videos'},
          {'icon': Icons.book, 'name': 'Books'},
          {'icon': Icons.work, 'name': 'Work'},
          {'icon': Icons.games, 'name': 'Games'},
          {'icon': Icons.store, 'name': 'Store'},
        ];

        final app = apps[index % apps.length];

        return AppTile(
          icon: app['icon'] as IconData,
          label: app['name'] as String,
          onTap:
              () => Navigator.pushNamed(
                context,
                '/${(app['name'] as String).toLowerCase()}',
              ),
        );
      },
    );
  }
}

class _DesktopHomeLayout extends StatelessWidget {
  final int selectedIndex;

  const _DesktopHomeLayout({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.count(
        crossAxisCount: 6,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          AppTile(
            icon: Icons.web,
            label: 'Browser',
            onTap: () => Navigator.pushNamed(context, '/browser'),
          ),
          AppTile(
            icon: Icons.text_snippet,
            label: 'Editor',
            onTap: () => Navigator.pushNamed(context, '/editor'),
          ),
          AppTile(
            icon: Icons.terminal,
            label: 'Terminal',
            onTap: () => Navigator.pushNamed(context, '/terminal'),
          ),
          AppTile(
            icon: Icons.folder,
            label: 'Files',
            onTap: () => Navigator.pushNamed(context, '/files'),
          ),
          AppTile(
            icon: Icons.calculate,
            label: 'Calculator',
            onTap: () => Navigator.pushNamed(context, '/calculator'),
          ),
          AppTile(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          // Add more app tiles here
        ],
      ),
    );
  }
}
