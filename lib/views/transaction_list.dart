import 'package:expense_tracker/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({super.key, required this.title});

  final String title;

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  final List<Transaction> _transactionList = [];

  void _createTransaction() {
    setState(() {
      _transactionList.add(Transaction(
        date: DateTime.now(),
        amount: 3.14,
        type: TransactionType.EXPENSE,
        category: "This is a category",
        comment: "This is a comment",
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _transactionList.length,
        itemBuilder: (context, index) =>
            TransactionCard(transaction: _transactionList[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTransaction,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(transaction.comment),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              transaction.amount.toString(),
            ),
          ],
        )
      ],
    );
  }
}
