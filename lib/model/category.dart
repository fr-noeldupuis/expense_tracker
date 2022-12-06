import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 3)
class Category {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  late int iconId;
  @HiveField(3)
  final int colorId;

  Category({
    required this.id,
    required this.name,
    required this.iconId,
    required this.colorId,
  });
}
