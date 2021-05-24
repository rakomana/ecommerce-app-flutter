import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CallApiProduct {
  var token;

  getToken() async {
    final localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

  products(apiUrl) async {
    var fullUrl = baseUrl + apiUrl;
    await getToken();

    return await http.get(
      fullUrl,
      headers: setHeaders(),
    );
  }

  product(apiUrl) async {
    var fullUrl = baseUrl + apiUrl;
    await getToken();

    return await http.get(
      fullUrl,
      headers: setHeaders(),
    );
  }

  cart(apiUrl) async {
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
