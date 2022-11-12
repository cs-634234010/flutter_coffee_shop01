// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_book_api1/screens/books/booklist_screen.dart';
import 'package:flutter_book_api1/screens/about/about_screen.dart';

class TabMenu extends StatelessWidget {
  final int currentTabIndex;
  TabMenu({
    Key? key,
    required this.currentTabIndex,
  }) : super(key: key);

  final List<Widget> tabs = [
    const Center(
      child: BookListScreen(),
    ),
    const Center(
      child: Text("Order List"),
    ),
    const Center(
      child: AboutScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return tabs[currentTabIndex];
  }
}
