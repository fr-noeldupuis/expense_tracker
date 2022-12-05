import 'package:expense_tracker/model/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransactionController {
  late Box transactionBox;

  List<Transaction> transactionsList = [];

  TransactionController() {
    transactionBox = Hive.box<Transaction>('transactions');
  }

  Future<void> saveTransaction(Transaction transaction) async {
    await transactionBox.put(DateTime.now().toIso8601String(), transaction);
  }

  List<Transaction> getAllTransactions() {
    return transactionBox.values.toList().cast<Transaction>();
  }

  ValueListenable getListenable() {
    return transactionBox.listenable();
  }
}
