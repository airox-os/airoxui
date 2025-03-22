import 'package:flutter/material.dart';
import 'src/config/theme.dart';
import 'src/config/routes.dart';

void main() {
  runApp(const AiroxApp());
}

class AiroxApp extends StatelessWidget {
  const AiroxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airox OS',
      theme: appTheme,
      routes: appRoutes,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
