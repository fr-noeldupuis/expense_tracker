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
          category: "This is a category"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              _transactionList.length.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTransaction,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
