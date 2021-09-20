import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CallApiAccount {
  var token;

  getToken() async {
    final localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

  account(data, apiUrl) async {
    var fullUrl = baseUrl + apiUrl;
    await getToken();

    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: setHeaders(),
    );
  }

  getAccount(apiUrl) async {
    var fullUrl = baseUrl + apiUrl;
    await getToken();

    return await http.get(
      fullUrl,
      headers: setHeaders(),
    );
  }

  logout(apiUrl) async {
    var fullUrl = baseUrl + apiUrl;
    await getToken();

    return await http.post(
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
