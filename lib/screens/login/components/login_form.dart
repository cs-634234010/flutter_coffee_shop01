import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_book_api1/providers/user_provider.dart';
import 'package:flutter_book_api1/screens/main/main_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  String errMsg = "";

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            //tip: selet method name then f12 goto that method
            //---User Name---
            usernameTextform(),

            const SizedBox(height: 10),

            //---Password---
            passwordTextform(),

            const SizedBox(height: 20),

            //---Login Button---
            loginButton(),
            const SizedBox(height: 15),

            //---Error Message---
            errorMsg(),
          ],
        ),
      ),
    );
  }

  //---Username Textform---
  TextFormField usernameTextform() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: userNameController,
      validator: (String? inputUsername) {
        if (inputUsername!.isEmpty) {
          return "Please input username.";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Enter username",
        fillColor: Colors.blueGrey[100],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey[700],
          size: 20.0,
        ),
      ),
    );
  }

  //---Password Textform----
  TextFormField passwordTextform() {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      validator: (String? inputPassword) {
        if (inputPassword!.isEmpty) {
          return "Please input password";
        } else {
          return null;
        }
      },
      onEditingComplete: () {
        checkLogin();
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        fillColor: Colors.blueGrey[100],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.grey[700],
          size: 20.0,
        ),
      ),
    );
  }

  //---Login Button----
  SizedBox loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: Colors.white),
          ),
        ),
        onPressed: checkLogin,
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
    );
  }

  //---Error Message----
  Text errorMsg() {
    return Text(
      errMsg,
      textAlign: TextAlign.start,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  //---Check Login Method----
  void checkLogin() async {
    FocusScope.of(context).unfocus();
    bool passValidate = formKey.currentState!.validate();
    if (passValidate) {
      Map result = await UserProvider()
          .signIn(userNameController.text, passwordController.text);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint(result["user"].toString());
      if (result["valid"]) {
        prefs.setInt('userId', result["userId"]);
        prefs.setString('username', result["username"]);
        prefs.setString('token', result["token"]);
        setState(() {
          errMsg = "";
        });
        debugPrint('valid');
        debugPrint(prefs.getString('token'));
        gotoHomepage();
      } else {
        prefs.remove('userId');
        prefs.remove('username');
        prefs.remove('token');

        setState(() {
          errMsg = "User or Password is invalid !";
        });
      }
    } else {
      setState(() {
        errMsg = "";
      });
    }
  }

  //---Send to HomePage Method----
  void gotoHomepage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
        (route) => false);
  }
}
