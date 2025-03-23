import 'package:flutter/material.dart';

class LockScreen extends StatelessWidget {
  final bool isMobile;
  final AnimationController fingerprintAnimation;
  final VoidCallback onUnlock;

  const LockScreen({
    super.key,
    required this.isMobile,
    required this.fingerprintAnimation,
    required this.onUnlock,
  });

  @override
  Widget build(BuildContext context) {
    // Create a more futuristic lock screen
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < -100) {
          onUnlock();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          // A more dynamic background
          gradient: LinearGradient(
            colors: [
              Colors.indigo.withOpacity(0.9),
              Colors.deepPurple.withOpacity(0.7),
              Colors.black.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Time display
                  Text(
                    DateTime.now().hour.toString().padLeft(2, '0') +
                        ':' +
                        DateTime.now().minute.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: isMobile ? 60 : 80,
                      fontWeight: FontWeight.w200,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),

                  Text(
                    'Swipe up to unlock',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: isMobile ? 16 : 20,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: isMobile ? 40 : 60),

                  // Fingerprint animation
                  AnimatedBuilder(
                    animation: fingerprintAnimation,
                    builder: (context, child) {
                      return Container(
                        width: isMobile ? 100 : 140,
                        height: isMobile ? 100 : 140,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(
                              0.2 + (0.3 * fingerprintAnimation.value),
                            ),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(
                                0.1 * fingerprintAnimation.value,
                              ),
                              blurRadius: 20,
                              spreadRadius: 5 * fingerprintAnimation.value,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.fingerprint,
                          size: isMobile ? 60 : 80,
                          color: Colors.white.withOpacity(
                            0.8 + (0.2 * fingerprintAnimation.value),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'AIROX OS',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
