import 'package:flutter/material.dart';
import 'dart:async';

/// A widget displaying system status information (time, battery, etc)
class SystemStatusBar extends StatefulWidget {
  final bool isDesktop;

  const SystemStatusBar({super.key, this.isDesktop = true});

  @override
  State<SystemStatusBar> createState() => _SystemStatusBarState();
}

class _SystemStatusBarState extends State<SystemStatusBar> {
  late Timer _timer;
  late String _timeString;
  late String _dateString;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => _updateTime(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    setState(() {
      _timeString = _formatTime(now);
      _dateString = _formatDate(now);
    });
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime dateTime) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    // Adjust day of week (0 is Monday in days array, but DateTime.weekday has 1 as Monday)
    final dayName = days[(dateTime.weekday - 1) % 7];
    final monthName = months[dateTime.month - 1];

    return '$dayName, $monthName ${dateTime.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
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

          // Middle - Date (only for desktop)
          if (widget.isDesktop)
            Text(_dateString, style: Theme.of(context).textTheme.labelMedium),

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
