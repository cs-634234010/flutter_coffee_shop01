import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//Import pakage for flutter_dotenv
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Import http
import 'package:http/http.dart' as http;
//Import book model
import 'package:flutter_book_api1/models/book.dart';



class CoffeeProvider {


  Future<List<Book>> getCoffee() async {
    //Using dotenv for API_URL
    String url ='${dotenv.env['API_URL']}coffees';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      "Authorization": "bearer $token"
    };

    //Using http to get book data
    http.Response response= await http.get(Uri.parse(url),headers: headers );
    
    //.then((response){
      if (response.statusCode == 200){
        return List<Book>.from(  
          jsonDecode  (response.body) ['data'].map( (bk)=> Book.fromJson(bk) ) );
      }else{
        throw Exception('Faild to load books');
      }
        
    }


  Book findByCoffee(int bookId, List<Book> items) {
    //Find book by BookId
    return items.firstWhere((bk) => bk.coffeeId == bookId);
   
  }

  List<Book> findBookTitle(String searchTitle, List<Book> items) {
    //Find book by Title
    return items
    .where(
      (bk) => bk.coffeeName.toLowerCase().contains(searchTitle.toLowerCase())    )
    .toList();

  
  }
}
