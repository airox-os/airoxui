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
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
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
            Icon(
              isSelected ? item.selectedIcon ?? item.icon : item.icon,
              color:
                  isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
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
        height: 66,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
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
          mainAxisSize: MainAxisSize.min,
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
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            item.icon,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
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
