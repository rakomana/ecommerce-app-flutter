import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop/components/default_button.dart';
import 'package:flutter_shop/screens/home/home_screen.dart';
import 'package:flutter_shop/size_config.dart';
import 'package:flutter_shop/api/products.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Access Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Go to home",
            press: () {
              _getProducts();
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }

  void _getProducts() async {
    var res = await CallApiProduct().products('products');
    var body = json.decode(res.body);

    if (body['success']) {
      var products = body['data'];
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('products', products);
      print('$products');
    }
  }
}
