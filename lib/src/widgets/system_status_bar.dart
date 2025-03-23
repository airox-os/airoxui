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

    final dayName = days[(dateTime.weekday - 1) % 7];
    final monthName = months[dateTime.month - 1];

    return '$dayName, $monthName ${dateTime.day}';
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Leftmost container (Date on mobile, empty on desktop)
          _buildDateContainer(isMobile),

          // Center container (Date and time on desktop, empty on mobile)
          if (!isMobile) _buildCenterContainer(),

          // Rightmost container (Battery and "Airox OS" on desktop, only battery on mobile)
          _buildRightContainer(isMobile),
        ],
      ),
    );
  }

  Widget _buildDateContainer(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _dateString,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontSize: isMobile ? 12 : 14,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildCenterContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$_dateString | $_timeString',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildRightContainer(bool isMobile) {
    return Row(
      children: [
        // Battery bar widget
        _buildBatteryBar(),
        if (!isMobile) const SizedBox(width: 8),
        if (!isMobile)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Airox OS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBatteryBar() {
    return Container(
      width: 40,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 30, // Example battery level (75%)
          height: 10,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
