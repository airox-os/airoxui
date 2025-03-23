import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/files_screen.dart';
import '../screens/terminal_screen.dart';
import '../screens/browser_screen.dart';
import '../screens/editor_screen.dart';
import '../screens/calculator_screen.dart';
import '../screens/profile_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/settings': (context) => const SettingsScreen(),
  '/files': (context) => const FilesScreen(),
  '/terminal': (context) => const TerminalScreen(),
  '/browser': (context) => const BrowserScreen(),
  '/editor': (context) => const EditorScreen(),
  '/calculator': (context) => const CalculatorScreen(),
  '/profile': (context) => const ProfileScreen(),
};

// Placeholder screens - Replace these with actual implementations
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Files')),
      body: const Center(child: Text('Files Screen')),
    );
  }
}

class TerminalScreen extends StatelessWidget {
  const TerminalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terminal')),
      body: const Center(child: Text('Terminal Screen')),
    );
  }
}

class BrowserScreen extends StatelessWidget {
  const BrowserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browser')),
      body: const Center(child: Text('Browser Screen')),
    );
  }
}

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editor')),
      body: const Center(child: Text('Editor Screen')),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: const Center(child: Text('Calculator Screen')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}
