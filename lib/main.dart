import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_book_api1/screens/login/login_screen.dart';
import 'package:flutter_book_api1/screens/main/main_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_book_api1/providers/cart_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env"); //ต้องมี env
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:   (context)=> CartProvider(), 
          )
      ],
      child: MaterialApp(
        title: 'ComSci Book Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
              .copyWith(secondary: Colors.green),
        ),
        home: FutureBuilder(
          future: checkToken(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                //debugPrint(snapshot.data.toString());
                return snapshot.data!
                    ? const MainScreen()
                    : const LoginScreen(); //if false returned from shared prefs go to home screen
              } //if null returned from shared prefs go to home screen
    
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }

  Future<bool> checkToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (!prefs.containsKey("token") || prefs.getString('token') == null)
        ? false
        : true;
  }
}
