import 'package:expense_tracker/model/category.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Category> initialCategories = [
  Category(
    id: 0,
    name: "Banque",
    colorId: 1,
    iconId: 1,
  ),
  Category(
    id: 1,
    name: "Maison",
    colorId: 2,
    iconId: 2,
  ),
  Category(
    id: 2,
    name: "Courses",
    colorId: 3,
    iconId: 3,
  ),
  Category(
    id: 3,
    name: "Work",
    colorId: 4,
    iconId: 4,
  ),
  Category(
    id: 4,
    name: "Autres",
    colorId: 0,
    iconId: 0,
  ),
];

const iconPack = [
  FontAwesomeIcons.piggyBank,
  FontAwesomeIcons.dollarSign,
  FontAwesomeIcons.house,
  FontAwesomeIcons.creditCard,
  FontAwesomeIcons.bagShopping,
];

const colorsPack = [
  Colors.amber,
  Colors.blue,
  Colors.blueAccent,
  Colors.blueGrey,
  Colors.cyan,
  Colors.cyanAccent,
];
