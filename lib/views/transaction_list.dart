import 'package:expense_tracker/const.dart';
import 'package:expense_tracker/controllers/controller.dart';
import 'package:expense_tracker/model/category.dart';
import 'package:expense_tracker/model/transaction.dart';
import 'package:expense_tracker/views/transaction_create.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({
    super.key,
    required this.title,
    required this.transactionController,
    required this.categoryController,
  });

  final String title;
  final TransactionController transactionController;
  final CategoryController categoryController;

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  Category? _selectedCategory;
  bool _floatingActionButtonVisible = true;

  _leaveCreation() {
    setState(() {
      _selectedCategory = null;
      _floatingActionButtonVisible = true;
    });
  }

  Widget _buildCategorySelectionDialog(BuildContext context) {
    return AlertDialog(
        title: const Text('Select Category'),
        content: SizedBox(
          width: 400,
          height: 300,
          child: ValueListenableBuilder(
            valueListenable: widget.categoryController.getListenable(),
            builder: (context, box, child) => GridView.count(
              childAspectRatio: 2 / 3,
              crossAxisCount: 4,
              children: box.values
                  .map<Widget>(
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
                              color: colorsPack.elementAt(e.colorId),
                            ),
                            child: Icon(iconPack.elementAt(e.iconId)),
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
          ValueListenableBuilder(
            valueListenable: widget.transactionController.getListenable(),
            builder: (context, box, child) => ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) => TransactionListElement(
                transaction: box.getAt(index)!,
                categoryController: widget.categoryController,
              ),
            ),
          ),
          if (_selectedCategory != null)
            TransactionCreatePage(
              onBackgroundClick: _leaveCreation,
              category: _selectedCategory!,
              onSubmit: _confirmTransactionCallback,
              transactionController: widget.transactionController,
            )
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

  _confirmTransactionCallback(Transaction? transaction) async {
    if (transaction != null) {
      await widget.transactionController.saveTransaction(transaction);
    }
    setState(() {
      _selectedCategory = null;
      _floatingActionButtonVisible = true;
    });
  }
}

class TransactionListElement extends StatelessWidget {
  final Transaction transaction;
  final CategoryController categoryController;
  const TransactionListElement({
    Key? key,
    required this.transaction,
    required this.categoryController,
  }) : super(key: key);

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
                    color: colorsPack.elementAt(categoryController
                        .getAt(transaction.categoryId!)
                        .colorId),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                      child: Icon(iconPack.elementAt(categoryController
                          .getAt(transaction.categoryId!)
                          .iconId)))),
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
