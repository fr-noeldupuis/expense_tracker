import 'package:expense_tracker/model/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Constructor creates a transaction', () async {
    Transaction transaction = Transaction(
        date: DateTime.now(),
        type: TransactionType.EXPENSE,
        comment: "This is a comment",
        amount: 3.14,
        category: "Test Category");
  });
}
