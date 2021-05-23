import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CallApi {
  var token;

  _getToken() async {
    final localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

  login(data, apiUrl) async {
    var fullUrl = baseUrl + apiUrl;

    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: setHeaders(),
    );
  }

  register(data, apiUrl) async {
    var fullUrl = baseUrl + apiUrl;

    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: setHeaders(),
    );
  }

  getUser(apiUrl) async {
    var fullUrl = baseUrl + apiUrl;

    return await http.get(
      fullUrl,
      headers: setHeaders(),
    );
  }

  otp(data, apiUrl) async {
    var fullUrl = baseUrl + apiUrl;
    await _getToken();
    //print('$data');
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: setHeaders(),
    );
  }

  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
