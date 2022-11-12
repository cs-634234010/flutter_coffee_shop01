import 'dart:convert';
//Import pakage for flutter_dotenv
import 'package:flutter_dotenv/flutter_dotenv.dart';

//Import http
import 'package:http/http.dart' as http;

class UserProvider {
  Future<Map> signIn(username, password) async {
    //Using dotenv for API_URL
    String url = '${dotenv.env['API_URL']}users/auth/signin'; 

    //Set Headers
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
    };

    //Using http to verify username and password
    return http
        .post(
      Uri.parse(url),
      headers: headers,
      body: json.encode({
        'username': username,
        'password': password,
      }),
    )
        .then((response) {
      if (response.statusCode == 201) {
        String token = jsonDecode(response.body)['accessToken'];
        int userId = jsonDecode(response.body)['userId'];

        return {
          'valid': true,
          'userId': userId,
          "username": username,
          "token": token
};
      }else {
        return {"valid": false};
      }
   });
  }
}
