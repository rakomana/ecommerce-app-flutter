import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CallApiCart {
  var token;

  getToken() async {
    final localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

  cart(apiUrl) async {
    var fullUrl = baseUrl + apiUrl;
    await getToken();

    return await http.get(
      fullUrl,
      headers: setHeaders(),
    );
  }

    getCart(apiUrl) async {
    var fullUrl = baseUrl + apiUrl;
    await getToken();

    return await http.get(
      fullUrl,
      headers: setHeaders(),
    );
  }

  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
