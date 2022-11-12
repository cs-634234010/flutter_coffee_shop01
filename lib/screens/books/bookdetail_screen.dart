import 'package:flutter/material.dart';

//import cached_network_image
import 'package:cached_network_image/cached_network_image.dart';

import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_book_api1/models/book.dart';
import 'package:flutter_book_api1/models/cart.dart';
import 'package:flutter_book_api1/screens/books/components/bookitem_add.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  const BookDetailScreen({
    Key? key,
    required this.book,
  }) : super(key: key);

  Widget buildButtomSheet(BuildContext context) {
    return AddBookItem(
        cartItem: CartItem(
            coffeeId: book.coffeeId,
            coffeeName: book.coffeeName,
            coffeePrice: book.coffeePrice,
            coffeePicture: book.coffeeDescription,
            coffeeDescription: book.coffeeDescription,
            qty: 1));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DateFormat formatter = DateFormat(dotenv.env['APP_DATE_FORMAT']);
    final String publishedate =
        formatter.format(DateTime.parse(book.coffeeDescription));

    return Scaffold(
        appBar: AppBar(
          title: Text(book.coffeeName),
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.shopping_cart),
          label: const Text("Add to Cart"),
          onPressed: () {
            //Show Add item to cart
            showModalBottomSheet(context: context, builder: buildButtomSheet);
          },
          backgroundColor: Colors.blueAccent.withOpacity(0.8),
        ),
        body: ListView(
          children: [
            bookCover(size),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: size.width * 0.9,
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          book.coffeeName,
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    bookFields("Author : ", book.coffeeName),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          "Price : ",
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            '    ฿ ${book.coffeePrice}    ',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    ),
                    bookFields("Category : ", book.coffeeName),
                    const SizedBox(
                      height: 2,
                    ),
                    bookFields("Publish Date : ", publishedate),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Description : ",
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700)),
                    ),
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      padding: const EdgeInsets.all(5),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Container bookCover(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      child: Column(
        children: [
          Container(
            height: size.height * 0.3,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.3,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),

                //Using CachedNetworkImage
                Center(
                  child: CachedNetworkImage(
                    imageUrl: book.coffeePicture,
                    height: size.height * 0.24,
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/book_loading.png',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row bookFields(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        Text(
          value,
          style: GoogleFonts.lato(
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
