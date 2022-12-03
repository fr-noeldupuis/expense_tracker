import 'dart:ui';

import 'package:expense_tracker/const.dart';
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

  Category? _selectedCategory;
  bool _floatingActionButtonVisible = true;

  void _createTransaction() {
    setState(() {
      _transactionList.add(Transaction(
        date: DateTime.now(),
        amount: 3.14,
        type: TransactionType.EXPENSE,
        category: initialCategories[0],
        comment: "This is a comment",
      ));
    });
  }

  Widget _buildCategorySelectionDialog(BuildContext context) {
    return AlertDialog(
        title: const Text('Select Category'),
        content: SizedBox(
          width: 400,
          height: 300,
          child: GridView.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 4,
            children: initialCategories
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedCategory = e;
                        _floatingActionButtonVisible = false;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: e.color,
                          ),
                          child: Icon(e.icon),
                        ),
                        Text(
                          e.name,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _transactionList.length,
            itemBuilder: (context, index) =>
                TransactionCard(transaction: _transactionList[index]),
          ),
          if (_selectedCategory != null)
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = null;
                      _floatingActionButtonVisible = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black38,
                          Colors.black45,
                          Colors.black87
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: _selectedCategory!.color,
                    child: SafeArea(
                      child: Text(_selectedCategory!.name),
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _floatingActionButtonVisible,
        child: FloatingActionButton(
          onPressed: () => {
            showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  Container(),
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                var curve = Curves.easeOutExpo.transform(animation.value);
                return Transform.scale(
                  scale: curve,
                  child: _buildCategorySelectionDialog(context),
                );
              },
              transitionDuration: const Duration(milliseconds: 100),
            )
          },
          child: const Icon(Icons.add),
        ),
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
                  child: Center(child: Icon(transaction.category?.icon))),
              Text(
                transaction.comment,
                style: const TextStyle(
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
                  "${transaction.amount} €",
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
