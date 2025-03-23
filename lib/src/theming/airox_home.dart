import 'package:flutter/material.dart';
import '../utils/ui_styling.dart';
import '../widgets/weather_card.dart';
import '../widgets/recent_apps_card.dart';

/// A styled homepage implementation with 3D effects
class AiroxHomePage extends StatelessWidget {
  const AiroxHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AiroxUIStyling.elevatedScaffoldBackground(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with shadows
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Time with shadow
                    Text(
                      "10:30 AM",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: AiroxUIStyling.textShadows(),
                      ),
                    ),

                    // Elevated settings button
                    Container(
                      decoration: AiroxUIStyling.glassButton(
                        baseColor: Colors.white,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                          shadows: AiroxUIStyling.iconShadows(),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Date with shadow
                Text(
                  "Monday, July 10",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    shadows: AiroxUIStyling.textShadows(),
                  ),
                ),

                const SizedBox(height: 30),

                // Quick actions row with elevated buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickActionButton(
                      context,
                      Icons.wifi,
                      Colors.teal,
                      "Wi-Fi",
                    ),
                    _buildQuickActionButton(
                      context,
                      Icons.bluetooth,
                      Colors.blue,
                      "Bluetooth",
                    ),
                    _buildQuickActionButton(
                      context,
                      Icons.brightness_6,
                      Colors.amber,
                      "Brightness",
                    ),
                    _buildQuickActionButton(
                      context,
                      Icons.volume_up,
                      Colors.purple,
                      "Volume",
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Weather card is already enhanced with 3D styling
                Center(
                  child: WeatherCard(
                    temperature: 28.5,
                    condition: "Sunny",
                    location: "San Francisco",
                  ),
                ),

                const SizedBox(height: 20),

                // Recent apps card is already enhanced with 3D styling
                Center(
                  child: RecentAppsCard(
                    recentApps: [
                      RecentAppItem(
                        name: "Files",
                        icon: Icons.folder,
                        color: Colors.blue,
                        onTap: () {},
                      ),
                      RecentAppItem(
                        name: "Music",
                        icon: Icons.music_note,
                        color: Colors.deepPurple,
                        onTap: () {},
                      ),
                      RecentAppItem(
                        name: "Photos",
                        icon: Icons.photo,
                        color: Colors.red,
                        onTap: () {},
                      ),
                      RecentAppItem(
                        name: "Terminal",
                        icon: Icons.terminal,
                        color: Colors.green,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Search bar with 3D effects
                Container(
                  decoration: AiroxUIStyling.elevatedContainer(
                    baseColor: Colors.grey.shade800,
                    borderRadius: 30,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        shadows: AiroxUIStyling.iconShadows(),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search applications...",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              shadows: AiroxUIStyling.textShadows(),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            shadows: AiroxUIStyling.textShadows(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    IconData icon,
    Color color,
    String label,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: AiroxUIStyling.elevatedIconButton(baseColor: color),
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
            shadows: AiroxUIStyling.iconShadows(customColor: color.darken()),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            shadows: AiroxUIStyling.textShadows(),
          ),
        ),
      ],
    );
  }
}

// Extension to darken colors for shadows
extension ColorExtension on Color {
  Color darken([double amount = 0.2]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
