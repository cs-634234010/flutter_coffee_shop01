import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_book_api1/providers/cart_provider.dart';
import 'package:flutter_book_api1/screens/cart/cart_screen.dart';

class Badge extends StatelessWidget {
  final Color? color;

  const Badge({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
              },
            ),
            Positioned(
              right: 6,
              top: 8,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: color ?? Colors.red,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),

                    //Use Provider for getting number of items in cart
                    child: Text(
                      '1',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
            )
          ],
        ),
      ],
    );
  }
}
