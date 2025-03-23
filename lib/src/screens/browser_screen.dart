import 'package:flutter/material.dart';

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
