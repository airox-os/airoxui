import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/config/theme.dart';
import 'src/config/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const AiroxOS());
}

class AiroxOS extends StatelessWidget {
  const AiroxOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airox OS',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system, // Respect system theme setting
      routes: appRoutes,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
