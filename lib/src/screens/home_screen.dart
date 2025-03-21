import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Airox OS UI'),
            // ...other UI components...
          ],
        ),
      ),
      // ...other scaffold components...
    );
  }
}
