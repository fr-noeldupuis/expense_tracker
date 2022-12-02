import 'dart:ui';

import 'package:expense_tracker/model/category.dart';
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
        category: Category(
          name: "Category Standard",
          icon: Icon(Icons.account_balance),
          color: Colors.blue,
        ),
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
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: transaction.category?.color,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(child: transaction.category?.icon)),
              Text(
                transaction.comment,
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transaction.amount.toString() + " €",
                  style: TextStyle(
                      color: _transactionColorSelection(transaction),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color _transactionColorSelection(Transaction transaction) {
    switch (transaction.type) {
      case TransactionType.EXPENSE:
        return Colors.red;
      case TransactionType.REVENUE:
        return Colors.green;
      case TransactionType.TRANSFER:
        return Colors.grey;
    }
  }
}
