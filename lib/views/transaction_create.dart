import 'package:expense_tracker/controllers/controller.dart';
import 'package:expense_tracker/model/category.dart';
import 'package:expense_tracker/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionCreate extends StatefulWidget {
  const TransactionCreate({
    super.key,
    required this.category,
    required this.onConfirm,
    required this.transactionController,
  });

  final Category category;
  final void Function(Transaction?) onConfirm;
  final TransactionController transactionController;

  @override
  State<TransactionCreate> createState() => _TransactionCreateState();
}

class _TransactionCreateState extends State<TransactionCreate> {
  String _amount = "0";
  String _comment = "Comment";

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$_amount €",
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
                    onTap: _removeLast,
                    child: const Icon(FontAwesomeIcons.deleteLeft),
                  ),
                  Button(
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      double transactionAmount = _parseAmount();
                      Transaction? transaction;
                      if (transactionAmount != 0) {
                        transaction = Transaction(
                            id: widget.transactionController.getNextId(),
                            date: DateTime.now(),
                            amount: _parseAmount(),
                            type: TransactionType.EXPENSE,
                            categoryId: widget.category.id,
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
    );
  }
}

class Button extends StatelessWidget {
  const Button({
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

class TransactionCreatePage extends StatelessWidget {
  const TransactionCreatePage({
    super.key,
    required this.onBackgroundClick,
    required this.category,
    required this.onSubmit,
    required this.transactionController,
  });

  final VoidCallback onBackgroundClick;
  final Category category;
  final void Function(Transaction?) onSubmit;
  final TransactionController transactionController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onBackgroundClick,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.black38, Colors.black45, Colors.black87],
              ),
            ),
          ),
        ),
        TransactionCreate(
          category: category,
          onConfirm: onSubmit,
          transactionController: transactionController,
        )
      ],
    );
  }
}
