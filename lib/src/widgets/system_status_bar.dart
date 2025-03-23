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
        color: Colors.transparent, // Make the status bar itself transparent
        borderRadius: BorderRadius.circular(isMobile ? 0 : 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time container for mobile or date for desktop
          _buildHexagonContainer(
            isMobile,
            child: Text(
              isMobile ? _timeString : _dateString, // Show time for mobile
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: isMobile ? 12 : 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.purple.withOpacity(0.6),
          ),

          // Center container for desktop with animated gradient
          if (!isMobile) _buildAnimatedContainer(),

          // System indicators in circular containers
          _buildSystemIndicators(isMobile),
        ],
      ),
    );
  }

  Widget _buildHexagonContainer(
    bool isMobile, {
    required Widget child,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildAnimatedContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.6),
            Colors.deepPurple.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            _dateString,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          Icon(Icons.access_time, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            _timeString,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemIndicators(bool isMobile) {
    return Row(
      children: [
        // Add network and Wi-Fi icons for mobile
        if (isMobile) ...[
          _buildIconWithBackground(
            icon: Icons.network_cell,
            backgroundColor: Colors.blueGrey.withOpacity(0.5),
          ),
          const SizedBox(width: 8),
          _buildIconWithBackground(
            icon: Icons.wifi,
            backgroundColor: Colors.blue.withOpacity(0.5),
          ),
        ],

        // Add Wi-Fi and speaker icons for desktop
        if (!isMobile) ...[
          _buildIconWithBackground(
            icon: Icons.wifi,
            backgroundColor: Colors.blue.withOpacity(0.5),
          ),
          const SizedBox(width: 8),
          _buildIconWithBackground(
            icon: Icons.volume_up,
            backgroundColor: Colors.green.withOpacity(0.5),
          ),
        ],

        const SizedBox(width: 8),

        // Unique battery widget
        _buildUniqueBatteryWidget(),
      ],
    );
  }

  Widget _buildIconWithBackground({
    required IconData icon,
    required Color backgroundColor,
  }) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 16, color: Colors.white),
    );
  }

  Widget _buildUniqueBatteryWidget() {
    final bool isCharging =
        true; // This could be dynamic based on actual charging state

    return Container(
      width: 50,
      height: 20,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white30, width: 1),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 7, // 70% battery
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.greenAccent, Colors.green],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              Expanded(
                flex: 3, // 30% empty
                child: Container(),
              ),
              const SizedBox(width: 2),
              Container(
                width: 3,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),

          // Charging zap indicator
          if (isCharging)
            Center(
              child: Icon(Icons.bolt, color: Colors.yellow.shade300, size: 14),
            ),
        ],
      ),
    );
  }
}
