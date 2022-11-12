import 'package:flutter/material.dart';
import 'package:flutter_book_api1/screens/main/components/tab_menu.dart';
import 'package:flutter_book_api1/screens/main/components/bottom_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentMenuIndex = 0;

  void setMenu(int newIndex) {
    setState(() {
      _currentMenuIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabMenu(
        currentTabIndex: _currentMenuIndex,
      ),
      bottomNavigationBar: BottomMenu(
        currentBottomMenuIndex: _currentMenuIndex,
        setMenu: setMenu,
      ),
    );
  }
}
