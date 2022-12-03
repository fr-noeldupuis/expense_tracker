import 'package:expense_tracker/model/transaction.dart';

class TransactionController {
  List<Transaction> transactionsList = [];

  TransactionController();

  void saveTransaction(Transaction transaction) {
    transactionsList.add(transaction);
  }

  List<Transaction> getAllTransactions() {
    return transactionsList;
  }
}
