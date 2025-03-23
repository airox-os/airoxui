import 'package:flutter/material.dart';

/// A dock widget that displays application shortcuts in MacOS or Android style
class Dock extends StatelessWidget {
  final bool isMobile;
  final List<DockItem> items;
  final int selectedIndex;
  final Function(int)? onItemSelected;

  const Dock({
    super.key,
    required this.items,
    this.isMobile = false,
    this.selectedIndex = 0,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileDock(context);
    } else {
      return _buildDesktopDock(context);
    }
  }

  Widget _buildMobileDock(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2, // Add small vertical margin to fix the 2.0px overflow
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.6),
            Colors.indigo.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          20,
        ), // Full rounded corners all around
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        // Add ClipRRect to prevent overflow rendering
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Background light effects
            Positioned(
              top: 10,
              child: Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),

            // The main dock items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                items.length,
                (index) => _buildFloatingDockItem(context, items[index], index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingDockItem(
    BuildContext context,
    DockItem item,
    int index,
  ) {
    final isSelected = index == selectedIndex;

    // Calculate available height for content
    const double containerHeight = 72.0; // Total height of mobile dock
    const double itemHeight = 50.0; // Height of icon container
    const double spacing = 4.0; // Spacing between icon and label
    const double labelHeight = 14.0; // Approximate height of label with padding

    // Calculate maximum available vertical translation that won't cause overflow
    const double maxTranslation =
        (containerHeight - itemHeight - spacing - labelHeight) / 2;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform:
          isSelected
              ? Matrix4.translationValues(0, -maxTranslation, 0)
              : Matrix4.translationValues(0, 0, 0),
      child: InkWell(
        onTap: () {
          item.onTap?.call();
          onItemSelected?.call(index);
        },
        customBorder: const CircleBorder(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient:
                    isSelected
                        ? LinearGradient(
                          colors: [Colors.amber, Colors.orange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                        : null, // Remove gradient for unselected state
                color:
                    isSelected
                        ? null
                        : item.backgroundColor, // Use unique background color
                shape: BoxShape.circle,
                boxShadow:
                    isSelected
                        ? [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ]
                        : [],
              ),
              child: Icon(
                isSelected ? item.selectedIcon ?? item.icon : item.icon,
                color: isSelected ? Colors.white : Colors.white70,
                size: 26,
              ),
            ),
            SizedBox(height: spacing),
            if (isSelected)
              SizedBox(
                height: labelHeight, // Fixed height container for label
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              SizedBox(height: labelHeight), // Placeholder with same height
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopDock(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 20),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Background glass panel
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.withOpacity(0.7),
                    Colors.blue.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              // Dock indicator line
              child: Center(
                child: Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            // Dock items
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                items.length,
                (index) => _buildDesktopDockItem(context, items[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopDockItem(BuildContext context, DockItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MouseRegion(
        onEnter: (_) {
          // In a real app, you'd animate the hover effect here
        },
        onExit: (_) {
          // Reset the animation on exit
        },
        child: GestureDetector(
          onTap: item.onTap,
          child: _buildFuturisticDockIcon(context, item),
        ),
      ),
    );
  }

  Widget _buildFuturisticDockIcon(BuildContext context, DockItem item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.amber.withOpacity(0.7),
                Colors.deepOrange.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Center(child: Icon(item.icon, size: 30, color: Colors.white)),
        ),
        if (item.showDot)
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class DockItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final VoidCallback? onTap;
  final bool showDot;
  final Color backgroundColor; // Add backgroundColor property

  const DockItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
    this.onTap,
    this.showDot = false,
    required this.backgroundColor, // Make backgroundColor required
  });
}
