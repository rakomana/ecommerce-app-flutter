import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_shop/api/cart.dart';
import 'package:flutter_shop/models/Product.dart';
import 'package:flutter_shop/screens/home/home_screen.dart';
import 'package:flutter_shop/screens/sign_in/sign_in_screen.dart';

import '../../../size_config.dart';
import '../../../constants.dart';
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future getCart() async {
    var res = await CallApiCart().cart('cart');
    var body = json.decode(res.body);
    var item = body['items'];
    List<Product> demoProducts = [];

    if (body['success'] == true) {
      for (var u in item) {
        Map relation = u['pivot'];
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
          pivot: relation['quantity'],
        );
        demoProducts.add(product);
      }
      print(demoProducts.length);
      return demoProducts;
    } else if (body['success'] == false) {
      //show success notification
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Cart'),
          content: const Text('Oops!, your trolley is empty'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
              child: const Text('Continue shopping'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
              child: const Text('Trolleyway Deals'),
            ),
          ],
        ),
      );
    } else {
      Navigator.pushNamed(context, SignInScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: FutureBuilder(
        future: getCart(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading...'),
              ),
            );
          } else
            return Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: Key(snapshot.data[index].id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {},
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              SvgPicture.asset("assets/icons/Trash.svg"),
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 88,
                              child: AspectRatio(
                                aspectRatio: 0.88,
                                child: Container(
                                  padding: EdgeInsets.all(
                                      getProportionateScreenWidth(10)),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.network(
                                    imageNetwork + snapshot.data[index].images,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 40),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index].title,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 10),
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          "\R${snapshot.data[index].newPrice}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor),
                                      children: [
                                        TextSpan(
                                            text:
                                                " x${snapshot.data[index].pivot}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
        },
      ),
    );
  }
}
//https://www.youtube.com/watch?v=mgRDswsMRKU
//thisa video helped reading nested json
