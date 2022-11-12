import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_book_api1/models/cart.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.coffeePrice * cartItem.qty;
    });
    return total;
  }

  String toJson() {
    String jsonString = "";

    if (_items.isNotEmpty) {
      _items.forEach((key, item) {
        String jsonStringItem = '''
      {
        "bookId": ${item.coffeeId},
        "price": ${item.coffeePrice},
        "qty": ${item.qty}
      },''';
        jsonString = jsonString + jsonStringItem;
      });
      jsonString = "[${jsonString.substring(0, jsonString.length - 1)}]";
    }

    return jsonString;
  }

  void clearCart() {
    _items.clear();
  }

  void addItem(CartItem cartItem) {
    if (_items.containsKey(cartItem.coffeeId)) {
      _items.update(
        cartItem.coffeeId,
        (existingCartItem) => CartItem(
          coffeeId: existingCartItem.coffeeId,
          coffeeName: existingCartItem.coffeeName,
          coffeePrice: existingCartItem.coffeePrice,
          qty: cartItem.qty,
          coffeePicture: existingCartItem.coffeePicture,
          coffeeDescription: cartItem.coffeeDescription
        ),
      );
    } else {
      _items.putIfAbsent(
        cartItem.coffeeId,
        () => CartItem(
          coffeeId: cartItem.coffeeId,
          coffeeName: cartItem.coffeeName,
          coffeePrice: cartItem.coffeePrice,
          qty: cartItem.qty,
          coffeePicture: cartItem.coffeePicture,
          coffeeDescription: cartItem.coffeeDescription
        ),
      );
    }
  }

  void removeItem(int bookId) {
    _items.remove(bookId);
  }

  void increaseItem(int bookId) {
    _items.update(
      bookId,
      (existingCartItem) => CartItem(
        coffeeId: existingCartItem.coffeeId,
        coffeeName: existingCartItem.coffeeName,
        coffeePrice: existingCartItem.coffeePrice,
        qty: existingCartItem.qty + 1,
        coffeePicture: existingCartItem.coffeePicture,
        coffeeDescription:existingCartItem.coffeeDescription
      ),
    );
  }

  void decreaseItem(int bookId) {
    _items.update(
      bookId,
      (existingCartItem) => CartItem(
        coffeeId: existingCartItem.coffeeId,
        coffeeName: existingCartItem.coffeeName,
        coffeePrice: existingCartItem.coffeePrice,
        qty: (existingCartItem.qty > 1)
            ? existingCartItem.qty - 1
            : existingCartItem.qty,
        coffeePicture: existingCartItem.coffeePicture,
        coffeeDescription: existingCartItem.coffeeDescription
      ),
    );
  }

  void addOrder(name, address) async {
    String url = '${dotenv.env['API_URL']}orders';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('userId');
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      "Authorization": "bearer $token"
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode({
        'userId': userId,
        'name': name,
        'address': address,
        'total': totalAmount,
        'details': toJson(),
      }),
    );

    if (response.statusCode == 200) {
      clearCart();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
