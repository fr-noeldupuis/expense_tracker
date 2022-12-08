import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class Account {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double initialAmount;

  Account({
    required this.id,
    required this.name,
    this.initialAmount = 0,
  });
}
