import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part '../adapters/category.g.dart';

@HiveType(typeId: 3)
class Category {
  @HiveField(0)
  final String name;
  @HiveField(1)
  late int iconCodePoint;
  @HiveField(2)
  late String? iconFontFamily;
  @HiveField(3)
  late String? iconFontPackage;
  @HiveField(4)
  final Color color;

  Category({
    required this.name,
    required this.iconCodePoint,
    required this.iconFontFamily,
    required this.iconFontPackage,
    required this.color,
  });
}
