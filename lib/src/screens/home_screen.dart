import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/adaptive_layout.dart';
import '../widgets/app_tile.dart';
import '../widgets/system_status_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const AdaptiveLayout(
        mobile: _MobileHomeLayout(),
        desktop: _DesktopHomeLayout(),
      ),
      bottomNavigationBar:
          MediaQuery.of(context).size.width < 600
              ? NavigationBar(
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.apps_outlined),
                    selectedIcon: Icon(Icons.apps),
                    label: 'Applications',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.folder_outlined),
                    selectedIcon: Icon(Icons.folder),
                    label: 'Files',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.terminal),
                    label: 'Terminal',
                  ),
                ],
                selectedIndex: 0,
                onDestinationSelected: (index) {
                  // Navigate to the selected destination
                },
              )
              : null,
    );
  }
}

class _MobileHomeLayout extends StatelessWidget {
  const _MobileHomeLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SystemStatusBar(),
        Expanded(
          child: ListView(
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
          ),
        ),
      ],
    );
  }
}

class _DesktopHomeLayout extends StatelessWidget {
  const _DesktopHomeLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Desktop sidebar navigation
        NavigationRail(
          extended: MediaQuery.of(context).size.width > 1000,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.apps_outlined),
              selectedIcon: Icon(Icons.apps),
              label: Text('Applications'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.folder_outlined),
              selectedIcon: Icon(Icons.folder),
              label: Text('Files'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.terminal),
              label: Text('Terminal'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
          selectedIndex: 0,
          onDestinationSelected: (index) {
            // Navigate to the selected destination
          },
        ),

        // Main content area
        Expanded(
          child: Column(
            children: [
              const SystemStatusBar(),
              Expanded(
                child: Padding(
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
                        onTap:
                            () => Navigator.pushNamed(context, '/calculator'),
                      ),
                      AppTile(
                        icon: Icons.settings,
                        label: 'Settings',
                        onTap: () => Navigator.pushNamed(context, '/settings'),
                      ),
                      // Add more app tiles here
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
