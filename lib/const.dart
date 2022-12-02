import 'package:expense_tracker/model/category.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const List<Category> initialCategories = [
  Category(
    name: "Banque",
    icon: FontAwesomeIcons.buildingColumns,
    color: Colors.green,
  ),
  Category(
    name: "Maison",
    icon: FontAwesomeIcons.house,
    color: Colors.blue,
  ),
  Category(
    name: "Courses",
    icon: FontAwesomeIcons.basketShopping,
    color: Colors.yellow,
  ),
  Category(
    name: "Work",
    icon: FontAwesomeIcons.briefcase,
    color: Colors.red,
  ),
  Category(
    name: "Autres",
    icon: FontAwesomeIcons.bagShopping,
    color: Colors.red,
  ),
];
