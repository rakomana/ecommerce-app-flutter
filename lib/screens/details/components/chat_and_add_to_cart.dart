import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_shop/api/cart.dart';
import 'package:flutter_shop/screens/cart/cart_screen.dart';

import '../../../constants.dart';

class ChatAndAddToCart extends StatelessWidget {
  const ChatAndAddToCart({Key key}) : super(key: key);

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
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: 18,
          ),
          SizedBox(width: kDefaultPadding / 2),
          Text(
            "Chat",
            style: TextStyle(color: Colors.white),
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
    var res = await CallApiCart().cart('product/order/1');
    var body = json.decode(res.body);

    if (body['success']) {
      //show notification
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('item added to cart'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Continue shopping'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
              child: const Text('Go to Cart'),
            ),
          ],
        ),
      );
    }
  }
}
