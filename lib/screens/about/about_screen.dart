import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_bookshop/providers/cart_provider.dart';
// import 'package:flutter_bookshop/screens/bookListScreen/badge.dart';
// import 'package:flutter_bookshop_/screens/cartScreen/main.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        actions: [
          // Consumer<Cart>(
          //   builder: (_, cart, ch) => Badge(
          //     value: cart.itemCount.toString(),
          //     child: ch!,
          //   ),
          const Text("Badge"),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              size: 30,
            ),
            onPressed: () {
              //Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              width: 230,
              image: AssetImage('assets/images/logocomsci.jpg'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "\nComputer Science\nFaculty of Science and Technology\nRajabhat Songkhla University",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Text(
                "\nContact Us",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue[200],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: const Text(
                "website: cs.skru.ac.th\nfacebook.com/ComputerSciSKRU",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
