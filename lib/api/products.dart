import 'package:http/http.dart' as http;
import 'package:flutter_shop/api/auth.dart';

import '../constants.dart';

class CallApiProduct {

  products(apiUrl) async {
    var fullUrl = baseUrl + apiUrl;

    return await http.get(
      fullUrl,
      headers: CallApi().setHeaders(),
    );
  }

  product(apiUrl) async {
    var fullUrl = baseUrl + apiUrl;

    return await http.get(
      fullUrl,
      headers: CallApi().setHeaders(),
    );
  }
}