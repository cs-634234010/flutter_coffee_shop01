import 'package:flutter/material.dart';
import 'package:flutter_book_api1/providers/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_book_api1/models/cart.dart';
import 'package:provider/provider.dart';

class AddBookItem extends StatefulWidget {
  final CartItem cartItem;

  
  const AddBookItem({
    Key? key,
    required this.cartItem,   
  }) : super(key: key);

  @override
  State<AddBookItem> createState() => _AddBookItemState();
}

class _AddBookItemState extends State<AddBookItem> {
  late BuildContext scaffoldContext;
  late int _qty;

  @override
  void initState() {
    super.initState();
    _qty = widget.cartItem.qty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: Colors.black,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const Expanded(
              child: SizedBox(
                height: 10,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                widget.cartItem.coffeeName,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Price : ",
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                ),
                Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    '    ฿ ${widget.cartItem.coffeePrice}    ',
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_qty > 1) {
                          _qty = _qty - 1;
                        }
                      });
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: FittedBox(
                          child: Text(
                            '-',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Text(
                    '$_qty',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _qty = _qty + 1;
                      });
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 18,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: FittedBox(
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
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Total: \$${(widget.cartItem.coffeePrice * _qty)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: double.infinity,
                child: SizedBox(
                  height: 45,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () async {

                      },
                      child: Text(            
                        (context.read<CartProvider>().items.containsKey(widget.cartItem.coffeeId) == false)
                            ? "Add to Cart"
                            : "Update Cart",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                )),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.deepOrangeAccent,
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            ),
            const Expanded(
              child: SizedBox(
                height: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
