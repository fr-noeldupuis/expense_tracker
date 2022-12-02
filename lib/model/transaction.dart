class Transaction {
  int id = 0;
  DateTime date;
  double amount;
  TransactionType type;
  String comment = "";
  String category;

  Transaction(
      {required this.date,
      required this.amount,
      required this.type,
      this.category = "",
      this.comment = ""}) {
    if (type == TransactionType.EXPENSE || type == TransactionType.REVENUE) {
      throw MandatoryCategoryException();
    }
  }
}

enum TransactionType { EXPENSE, REVENUE, TRANSFER }

class MandatoryCategoryException implements Exception {}
