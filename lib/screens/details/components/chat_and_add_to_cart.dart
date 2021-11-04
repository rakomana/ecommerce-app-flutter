import 'dart:convert';
import 'package:flutter_shop/helper/keyboard.dart';
import 'package:get/get.dart';
import 'package:flutter_shop/api/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_shop/api/cart.dart';
import 'package:flutter_shop/screens/home/home_screen.dart';
import 'package:flutter_shop/screens/cart/cart_screen.dart';
import 'package:flutter_shop/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';

class ChatAndAddToCart extends StatelessWidget {
  final product;
  final _counter = 1.obs;
  ChatAndAddToCart({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFCBF1E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            height: 32,
            child: OutlineButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
              onPressed: () {
                if (_counter.value > 1) {
                  _counter.value--;
                }
              },
              child: Icon(Icons.remove),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Text(
                  _counter.value.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              )),
          SizedBox(
            width: 40,
            height: 32,
            child: OutlineButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
              onPressed: () {
                if (_counter.value < 10) {
                  _counter.value++;
                }
              },
              child: Icon(Icons.add),
            ),
          ),
          // it will cover all available spaces
          Spacer(),
          FlatButton.icon(
            onPressed: () {
              _addToCart(context);
            },
            icon: SvgPicture.asset(
              "assets/icons/shopping-bag.svg",
              height: 18,
            ),
            label: Text(
              "Add to Cart",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context) async {
    var res = await CallApiCart().cart('product/order/${product.id}/$_counter');
    var body = json.decode(res.body);

    if (body['success'] == 'true') {
      //show success notification
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('item added to cart'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
              child: const Text('Continue shopping'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, CartScreen.routeName),
              child: const Text('Go to Cart'),
            ),
          ],
        ),
      );
    } else {
      //check if user is authenticated if not login the user
      var res = await CallApi().getUser('user');
    var body = json.decode(res.body);

    if (body['success'] == 'true') {
      //show error notification
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Something went wrong'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
              child: const Text('Continue shopping'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Ok'),
              child: const Text('Go to Cart'),
            ),
          ],
        ),
      );
    } else {
        KeyboardUtil.hideKeyboard(context);
        Navigator.pushNamed(context, SignInScreen.routeName);
    }
    }
  }
}
