import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_shop/api/cart.dart';
import 'package:flutter_shop/models/Product.dart';
import 'package:flutter_shop/screens/cart/cart_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import 'dart:convert';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  Future getCountCart(BuildContext context) async {
    await checkInternetAccess(context);

    var res = await CallApiCart().cart('cart');
    var body = json.decode(res.body);
    var item = body['items'];
    List<Product> demoProducts = [];

    if (body['success']) {
      for (var u in item) {
        Product product = Product(
          id: u['id'],
          title: u['title'],
          description: u['description'],
          oldPrice: u['old_price'],
          newPrice: u['new_price'],
          quantity: u['quantity'],
          images: u['picture'],
          status: u['status'],
          name: u['name'],
          category: u['category'],
          colors: [
            Color(0xFFF6625E),
            Color(0xFF836DB8),
            Color(0xFFDECB9C),
            Colors.white,
          ],
          rating: 4.8,
        );
        demoProducts.add(product);
      }
      return demoProducts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          FutureBuilder(
              future: getCountCart(context),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return IconBtnWithCounter(
                    svgSrc: "assets/icons/Cart Icon.svg",
                    numOfitem: 0,
                    press: () => Navigator.pushNamed(context, CartScreen.routeName),
                  );
                }
                else {
                  return IconBtnWithCounter(
                    svgSrc: "assets/icons/Cart Icon.svg",
                    numOfitem: snapshot.data.length,
                    press: () => Navigator.pushNamed(context, CartScreen.routeName),
                  );
                }
              }),
        ],
      ),
    );
  }

  void showMyDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            'check your internet connection',
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  //check internet connection
  checkInternetAccess(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      print('disconnected');
      //
      showMyDialog(context);
    }
  }
}
