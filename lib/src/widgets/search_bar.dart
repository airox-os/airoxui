import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSearch;
  final String hintText;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.onSearch,
    this.hintText = 'Search apps, files, and more...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 14,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
        onSubmitted: (_) => onSearch?.call(),
      ),
    );
  }
}
