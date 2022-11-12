import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_book_api1/providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final int bookId;
  final int price;
  final int qty;
  final String title;
  final String thumbnailUrl;

  const CartItemWidget({
    Key? key,
    required this.bookId,
    required this.price,
    required this.qty,
    required this.title,
    required this.thumbnailUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Declare cartProvider

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(
              10.0,
              10.0,
            ),
          )
        ],
        color: Colors.grey.shade300,
      ),
      padding: const EdgeInsets.all(8),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 4),
        leading: CachedNetworkImage(
          imageUrl: thumbnailUrl,
          width: MediaQuery.of(context).size.width * 0.2,
          fit: BoxFit.fill,
          placeholder: (context, url) => Image.asset(
            'assets/images/book_loading.png',
            fit: BoxFit.cover,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        title: Text(title),
        subtitle: Column(
          children: [
            SizedBox(
              height: 30,
              width: double.infinity,
              child: Text(
                'Price: \$${(price)}',
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      //Decrease number of item in cart
                    },
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          '-',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Text(
                    '$qty',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  GestureDetector(
                    onTap: () {
                      //Increase number of item in cart
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 16,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${NumberFormat("#,###").format(price * qty)}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
