import 'package:flutter/material.dart';
import 'dart:async';

/// A widget displaying system status information (time, battery, etc)
class SystemStatusBar extends StatefulWidget {
  const SystemStatusBar({super.key});

  @override
  State<SystemStatusBar> createState() => _SystemStatusBarState();
}

class _SystemStatusBarState extends State<SystemStatusBar> {
  late Timer _timer;
  late String _timeString;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => _getTime(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.background.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Menu and app indicators
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text('Airox OS', style: Theme.of(context).textTheme.labelMedium),
            ],
          ),

          // Right side - System indicators
          Row(
            children: [
              const Icon(Icons.wifi, size: 16),
              const SizedBox(width: 12),
              const Icon(Icons.volume_up, size: 16),
              const SizedBox(width: 12),
              const Icon(Icons.battery_full, size: 16),
              const SizedBox(width: 8),
              Text(_timeString, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
