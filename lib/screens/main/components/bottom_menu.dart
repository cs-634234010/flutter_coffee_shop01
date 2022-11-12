import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:flutter_book_api1/screens/login/login_screen.dart';
import 'package:flutter_book_api1/screens/shared/shared_functions.dart';

class BottomMenu extends StatelessWidget {
  final int currentBottomMenuIndex;
  final Function setMenu;

  const BottomMenu({
    Key? key,
    required this.currentBottomMenuIndex,
    required this.setMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context);
    return BottomNavyBar(
      backgroundColor: Colors.black,
      selectedIndex: currentBottomMenuIndex,
      iconSize: 30,
      items: [
        BottomNavyBarItem(
          title: const Text("Coffees"),
          icon: const Icon(
            Icons.coffee,
            color: Colors.orangeAccent,
          ),
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
          title: const Text("Cart"),
          icon: const Icon(
            Icons.card_giftcard,
            color: Colors.blueAccent,
          ),
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
          title: const Text("About"),
          icon: const Icon(
            Icons.contact_support,
            color: Colors.yellow,
          ),
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
          title: const Text("Sign Out"),
          icon: const Icon(
            Icons.logout,
            color: Colors.greenAccent,
          ),
          activeColor: Colors.white,
        )
      ],
      onItemSelected: (index) {
        if (index != 3) {
          setMenu(index);
        } else {
          confirm(context);
        }
      },
    );
  }

  void confirm(BuildContext context) async {
    //-----Show Confirm Dialog
    await showConfirmDialog(context, "Sign out?", "Do you want to sign out?",
        () {
      signOut();
      //gotoLoginPage(context);
    }, () {
      Navigator.of(context).pop();
    });
    //-----End - Show Confirm Dialog
  }

  void signOut() async {
    //cart.clearCart();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('username');
    prefs.remove('token');
  }

  // void gotoLoginPage(context) {
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const LoginScreen(),
  //       ),
  //       (route) => false);
  // }
}
