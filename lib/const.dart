import 'package:expense_tracker/model/category.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Category> initialCategories = [
  Category(
    name: "Banque",
    color: Colors.green,
    iconCodePoint: FontAwesomeIcons.buildingColumns.codePoint,
    iconFontFamily: FontAwesomeIcons.buildingColumns.fontFamily,
    iconFontPackage: FontAwesomeIcons.buildingColumns.fontPackage,
  ),
  Category(
    name: "Maison",
    color: Colors.blue,
    iconCodePoint: FontAwesomeIcons.house.codePoint,
    iconFontFamily: FontAwesomeIcons.house.fontFamily,
    iconFontPackage: FontAwesomeIcons.house.fontPackage,
  ),
  Category(
    name: "Courses",
    color: Colors.yellow,
    iconCodePoint: FontAwesomeIcons.basketShopping.codePoint,
    iconFontFamily: FontAwesomeIcons.basketShopping.fontFamily,
    iconFontPackage: FontAwesomeIcons.basketShopping.fontPackage,
  ),
  Category(
    name: "Work",
    color: Colors.red,
    iconCodePoint: FontAwesomeIcons.briefcase.codePoint,
    iconFontFamily: FontAwesomeIcons.briefcase.fontFamily,
    iconFontPackage: FontAwesomeIcons.briefcase.fontPackage,
  ),
  Category(
    name: "Autres",
    color: Colors.red,
    iconCodePoint: FontAwesomeIcons.bagShopping.codePoint,
    iconFontFamily: FontAwesomeIcons.bagShopping.fontFamily,
    iconFontPackage: FontAwesomeIcons.bagShopping.fontPackage,
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
