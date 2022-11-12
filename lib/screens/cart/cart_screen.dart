import 'package:flutter/material.dart';
import 'package:flutter_book_api1/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:flutter_book_api1/providers/cart_provider.dart';
import 'package:flutter_book_api1/screens/cart/components/slideable_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    //Declare cartProvider
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              //Change 1 to using value from cartProvider
              itemCount: cartProvider.items.length,
              itemBuilder: (ctx, i) {
                return SlideableItem(
                  //Change to using value from cartProvider
                  item: (cartProvider.items.values.toList()[i]),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    //Change 0 to using value from cartProvider
                    label: Text(
                      '\$${NumberFormat("#,###").format(cartProvider.totalAmount)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6!.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    )),
                    child: const Text('PLACE ORDER'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}