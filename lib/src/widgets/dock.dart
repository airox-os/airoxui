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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.6),
            Colors.indigo.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          items.length,
          (index) => _buildMobileDockItem(context, items[index], index),
        ),
      ),
    );
  }

  Widget _buildMobileDockItem(BuildContext context, DockItem item, int index) {
    final isSelected = index == selectedIndex;
    return InkWell(
      onTap: () {
        item.onTap?.call();
        onItemSelected?.call(index);
      },
      child: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.amber.withOpacity(0.3)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isSelected ? item.selectedIcon ?? item.icon : item.icon,
                color: isSelected ? Colors.amber : Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 11,
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopDock(BuildContext context) {
    return Center(
      child: Container(
        height: 72,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.withOpacity(0.6),
              Colors.blue.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              items
                  .map((item) => _buildDesktopDockItem(context, item))
                  .toList(),
        ),
      ),
    );
  }

  Widget _buildDesktopDockItem(BuildContext context, DockItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: item.onTap,
          child: _buildDockIcon(context, item),
        ),
      ),
    );
  }

  Widget _buildDockIcon(BuildContext context, DockItem item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.amber.withOpacity(0.3),
                Colors.orange.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(item.icon, size: 28, color: Colors.white),
        ),
        if (item.showDot)
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
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

  const DockItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
    this.onTap,
    this.showDot = false,
  });
}
