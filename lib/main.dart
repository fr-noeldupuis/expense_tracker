import 'package:expense_tracker/const.dart';
import 'package:expense_tracker/controllers/controller.dart';
import 'package:expense_tracker/model/category.dart';
import 'package:expense_tracker/model/transaction.dart';
import 'package:expense_tracker/views/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ColorAdapter());
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<Category>('categories');
  CategoryController categoryController = CategoryController();
  TransactionController transactionController = TransactionController();
  for (var category in initialCategories) {
    await categoryController.save(category);
  }
  runApp(MyApp(
    transactionController: transactionController,
    categoryController: categoryController,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.transactionController,
    required this.categoryController,
  });

  final TransactionController transactionController;
  final CategoryController categoryController;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: TransactionListView(
        title: 'Flutter Demo Home Page',
        transactionController: transactionController,
        categoryController: categoryController,
      ),
    );
  }
}
