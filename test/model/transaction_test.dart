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

  test('Constructor creates a transaction with provided data', () async {
    DateTime transactionCreation = DateTime.now();

    Transaction transaction = Transaction(
        date: transactionCreation,
        type: TransactionType.EXPENSE,
        comment: "This is a comment",
        amount: 3.14,
        category: "Test Category");
    expect(transaction.amount, equals(3.14));
    expect(transaction.type, equals(TransactionType.EXPENSE));
    expect(transaction.comment, equals("This is a comment"));
    expect(transaction.date, equals(transactionCreation));
    expect(transaction.category, equals("Test Category"));
  });

  test('Constructor: no comment should init the comment to empty string',
      () async {
    DateTime transactionCreation = DateTime.now();

    Transaction transaction = Transaction(
        date: transactionCreation,
        type: TransactionType.EXPENSE,
        amount: 3.14,
        category: "Test Category");
    expect(transaction.amount, equals(3.14));
    expect(transaction.type, equals(TransactionType.EXPENSE));
    expect(transaction.comment, isEmpty);
    expect(transaction.date, equals(transactionCreation));
    expect(transaction.category, equals("Test Category"));
  });

  test('Constructor: Category is mandatory for EXPENSE and REVENUE Types',
      () async {
    DateTime transactionCreation = DateTime.now();
    expect(
        () => Transaction(
            date: transactionCreation,
            type: TransactionType.EXPENSE,
            amount: 3.14),
        throwsA(isA<MandatoryCategoryException>()));
    expect(
        () => Transaction(
            date: transactionCreation,
            type: TransactionType.REVENUE,
            amount: 3.14),
        throwsA(isA<MandatoryCategoryException>()));
  });
}
