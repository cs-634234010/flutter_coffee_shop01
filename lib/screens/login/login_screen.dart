import 'package:flutter/material.dart';
import 'package:flutter_book_api1/screens/login/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: const Text("Computer Science Book Shop"),
      ),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/topleft.png",
                color: Colors.white.withOpacity(0.5),
                colorBlendMode: BlendMode.softLight,
                width: size.width * 0.6,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/bottomright.png",
                color: Colors.white.withOpacity(0.7),
                colorBlendMode: BlendMode.softLight,
                width: size.width * 0.7,
              ),
            ),
            Positioned(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: const [
                      //SizedBox(height: size.height * 0.15),
                      Text(
                        "Welcome to \nComputer Science BookShop",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),

                      //--- Login Form ---
                      LoginForm(),

                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
