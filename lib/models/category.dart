import 'package:flutter/material.dart';

class Category {
  final String title;
  final Color color;
  final IconData? icon;

  const Category({
    required this.title,
    required this.color,
    this.icon,
  });
}
