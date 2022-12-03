// ignore_for_file: constant_identifier_names

import 'package:expense_tracker/model/category.dart';

class Transaction {
  int id = 0;
  DateTime date;
  double amount;
  TransactionType type;
  String comment = "";
  Category? category;

  Transaction(
      {required this.date,
      required this.amount,
      required this.type,
      this.category,
      this.comment = ""}) {
    if (category == null &&
        (type == TransactionType.EXPENSE || type == TransactionType.REVENUE)) {
      throw MandatoryCategoryException();
    }
  }
}

enum TransactionType { EXPENSE, REVENUE, TRANSFER }

class MandatoryCategoryException implements Exception {}
