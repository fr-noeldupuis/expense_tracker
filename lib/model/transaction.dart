// ignore_for_file: constant_identifier_names

import 'package:expense_tracker/model/category.dart';
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  double amount;
  @HiveField(3)
  TransactionType type;
  @HiveField(4)
  String comment = "";
  @HiveField(5)
  int? categoryId;

  Transaction(
      {required this.id,
      required this.date,
      required this.amount,
      required this.type,
      this.categoryId,
      this.comment = ""}) {
    if (categoryId == null &&
        (type == TransactionType.EXPENSE || type == TransactionType.REVENUE)) {
      throw MandatoryCategoryException();
    }
  }
}

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  EXPENSE,
  @HiveField(1)
  REVENUE,
  @HiveField(2)
  TRANSFER,
}

class MandatoryCategoryException implements Exception {}
