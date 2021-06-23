import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';

class CallApiForgotPassword {

  forgotPassword(data, apiUrl) async {
    var fullUrl = baseUrl + apiUrl;

    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: setHeaders(),
    );
  }

  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
