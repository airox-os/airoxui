import 'package:flutter/material.dart';
import 'dart:math' as math;

class WeatherCard extends StatefulWidget {
  final double temperature;
  final String condition;
  final String location;

  const WeatherCard({
    super.key,
    required this.temperature,
    required this.condition,
    required this.location,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard>
    with TickerProviderStateMixin {
  late AnimationController _cloudsController;

  @override
  void initState() {
    super.initState();
    _cloudsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat(reverse: false);
  }

  @override
  void dispose() {
    _cloudsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 180, // Explicitly set height to avoid layout issues
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.lightBlue.shade300, Colors.blue.shade700],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          // Enhanced outer shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
          // Secondary shadow
          BoxShadow(
            color: Colors.blue.shade900.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
          // Inner light reflection
          BoxShadow(
            color: Colors.blue.shade200.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: -3,
            offset: const Offset(0, -4),
          ),
          // Top edge highlight
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, -1),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.6), width: 2.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Animated clouds need to be in a sized container
            Positioned.fill(child: _buildAnimatedClouds()),

            // Weather content
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location with enhanced shadow
                Text(
                  widget.location,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.9),
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                      Shadow(
                        color: Colors.blue.shade900.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Temperature and condition in a row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Temperature with enhanced shadow
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.temperature.round()}',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                              Shadow(
                                color: Colors.blue.shade900.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '°C',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Weather condition with icon
                    _getWeatherIcon(widget.condition),
                  ],
                ),

                const SizedBox(height: 12),

                // Condition text with enhanced shadow
                Text(
                  widget.condition,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                      Shadow(
                        color: Colors.blue.shade900.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Additional weather info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildWeatherDetail(Icons.water_drop_outlined, "78%"),
                    _buildWeatherDetail(Icons.air, "8 km/h"),
                    _buildWeatherDetail(Icons.umbrella_outlined, "10%"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedClouds() {
    return AnimatedBuilder(
      animation: _cloudsController,
      builder: (context, child) {
        return SizedBox.expand(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: -30 + (100 * _cloudsController.value),
                child: Opacity(opacity: 0.7, child: _buildCloud(40)),
              ),
              Positioned(
                top: 30,
                right: -20 + (80 * (1 - _cloudsController.value)),
                child: Opacity(opacity: 0.5, child: _buildCloud(30)),
              ),
              Positioned(
                bottom: 50,
                left: 20 + (60 * _cloudsController.value),
                child: Opacity(opacity: 0.3, child: _buildCloud(25)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCloud(double size) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.white.withOpacity(0.9)],
        ),
        borderRadius: BorderRadius.circular(size),
        boxShadow: [
          // Bottom shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
          // Top highlight for 3D effect
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, -1),
          ),
          // Subtle inner shadow
          BoxShadow(
            color: Colors.blue.shade200.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          ),
        ],
        // Subtle border
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 0.5),
      ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // Outside shadow
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
          // Inner highlight for 3D effect
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 3,
            spreadRadius: 0,
            offset: const Offset(0, -1),
          ),
          // Deeper shadow
          BoxShadow(
            color: Colors.blue.shade900.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
        // Subtle border
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(1, 1),
              ),
              Shadow(
                color: Colors.blue.shade900.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
                Shadow(
                  color: Colors.blue.shade900.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getWeatherIcon(String condition) {
    IconData iconData = Icons.cloud;
    double size = 40;

    switch (condition.toLowerCase()) {
      case 'sunny':
        iconData = Icons.wb_sunny;
        break;
      case 'cloudy':
        iconData = Icons.cloud;
        break;
      case 'rainy':
        iconData = Icons.water_drop;
        break;
      case 'stormy':
        iconData = Icons.thunderstorm;
        break;
      case 'snowy':
        iconData = Icons.ac_unit;
        break;
      default:
        iconData = Icons.cloud;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.1),
          ],
          center: Alignment.topLeft,
          radius: 1.0,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          // Outer shadow
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
          // Secondary shadow
          BoxShadow(
            color: Colors.blue.shade900.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
          // Inner glow
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: -2,
            offset: const Offset(0, -2),
          ),
        ],
        // Subtle border
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.0),
      ),
      child: Icon(
        iconData,
        size: size,
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 6,
            offset: const Offset(1, 2),
          ),
          Shadow(
            color: Colors.blue.shade800.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
      ),
    );
  }
}
