import 'dart:ui';

import 'package:expense_tracker/const.dart';
import 'package:expense_tracker/model/category.dart';
import 'package:expense_tracker/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                TransactionCreate(
                    category: _selectedCategory!,
                    onConfirm: (transaction) {
                      setState(() {
                        if (transaction != null) {
                          _transactionList.add(transaction);
                        }
                        _selectedCategory = null;
                        _floatingActionButtonVisible = true;
                      });
                    })
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

class TransactionCreate extends StatefulWidget {
  TransactionCreate({
    Key? key,
    required this.category,
    required this.onConfirm,
  });

  final Category category;
  final void Function(Transaction?) onConfirm;

  @override
  State<TransactionCreate> createState() => _TransactionCreateState();
}

class _TransactionCreateState extends State<TransactionCreate> {
  String _amount = "0";
  String _comment = "Comment";
  bool _isTextEditing = false;

  void _addToAmount(String btnValue) {
    setState(() {
      if (btnValue != "+" && btnValue != "-" && btnValue != "*") {
        if (_amount == "0" && btnValue != ".") {
          _amount = btnValue;
        } else if (btnValue != "." &&
            (!_amount.contains(".") ||
                (_amount.contains(".") &&
                    _amount
                            .substring(_amount.lastIndexOf("."), _amount.length)
                            .length <=
                        2))) {
          _amount = _amount + btnValue;
        } else if (btnValue == "." && !_amount.contains(".")) {
          _amount = _amount + btnValue;
        }
      }
    });
  }

  void _removeLast() {
    setState(() {
      if (_amount.isNotEmpty && _amount.length != 1) {
        _amount = _amount.substring(0, _amount.length - 1);
      } else if (_amount.length == 1) {
        _amount = "0";
      }
    });
  }

  double _parseAmount() {
    return double.parse(_amount);
  }

  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _amount + " €",
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          TextField(
                            enabled: true,
                            showCursor: true,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Comment',
                            ),
                            onChanged: (value) {
                              _comment = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Button(
                      child: const Text(
                        "7",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("7"),
                    ),
                    Button(
                      child: const Text(
                        "8",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("8"),
                    ),
                    Button(
                      child: const Text(
                        "9",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("9"),
                    ),
                    Button(
                      child: const Text(
                        "+",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("+"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Button(
                      child: const Text(
                        "4",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("4"),
                    ),
                    Button(
                      child: const Text(
                        "5",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("5"),
                    ),
                    Button(
                      child: const Text(
                        "6",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("6"),
                    ),
                    Button(
                      child: const Text(
                        "-",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("-"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Button(
                      child: const Text(
                        "1",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("1"),
                    ),
                    Button(
                      child: const Text(
                        "2",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("2"),
                    ),
                    Button(
                      child: const Text(
                        "3",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("3"),
                    ),
                    Button(
                      child: const Text(
                        "*",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("*"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Button(
                      child: const Text(
                        ".",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("."),
                    ),
                    Button(
                      child: const Text(
                        "0",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () => _addToAmount("0"),
                    ),
                    Button(
                      child: const Icon(FontAwesomeIcons.deleteLeft),
                      onTap: _removeLast,
                    ),
                    Button(
                      color: Theme.of(context).primaryColor,
                      onTap: () {
                        double transactionAmount = _parseAmount();
                        Transaction? transaction;
                        if (transactionAmount != 0) {
                          transaction = Transaction(
                              date: DateTime.now(),
                              amount: _parseAmount(),
                              type: TransactionType.EXPENSE,
                              category: widget.category,
                              comment: _comment);
                        }
                        widget.onConfirm(transaction);
                      },
                      child: const Text(
                        "✓",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  Button({
    Key? key,
    required this.child,
    this.color,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor.withAlpha(400),
                width: 0.1,
              ),
              color: color ?? Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Center(child: child),
          ),
        ),
      ),
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
