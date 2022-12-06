import 'dart:math';

import 'package:expense_tracker/model/transaction.dart';
import 'package:expense_tracker/model/category.dart' as cat;
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransactionController {
  late Box transactionBox;

  TransactionController() {
    transactionBox = Hive.box<Transaction>('transactions');
  }

  Future<void> saveTransaction(Transaction transaction) async {
    await transactionBox.put(transaction.id, transaction);
  }

  List<Transaction> getAllTransactions() {
    return transactionBox.values.toList().cast<Transaction>();
  }

  ValueListenable getListenable() {
    return transactionBox.listenable();
  }

  int getNextId() {
    return transactionBox.values.fold(
            -1, (previousValue, element) => max(previousValue, element.id)) +
        1;
  }
}

class CategoryController {
  late Box categoryBox;

  CategoryController() {
    categoryBox = Hive.box<cat.Category>('categories');
  }

  int getNextId() {
    return categoryBox.values.fold(
            0, (previousValue, element) => max(previousValue, element.id)) +
        1;
  }

  ValueListenable getListenable() => categoryBox.listenable();

  Future<void> save(cat.Category category) async {
    await categoryBox.put(category.id, category);
  }

  cat.Category getAt(int categoryId) {
    return categoryBox.getAt(categoryId);
  }
}
