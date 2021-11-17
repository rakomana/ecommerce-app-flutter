import 'package:flutter/material.dart';
import 'package:flutter_shop/constants.dart';
import 'package:flutter_shop/size_config.dart';

import 'chat_and_add_to_cart.dart';
import 'list_of_colors.dart';
import 'product_image.dart';

class Body extends StatelessWidget {
  final product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: '${product.id}',
                      child: ProductPoster(
                        size: size,
                        image: imageNetwork + product.images,
                      ),
                      // end to remove
                    ),
                  ),
                  // to remove
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        product.pictures.length,
                        (index) => buildSmallReview(index),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      product.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    '\R${product.newPrice}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child: Text(
                      product.description,
                      style: TextStyle(color: kTextColor),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
            ChatAndAddToCart(product: product),
          ],
        ),
      ),
    );
  }

  Container buildSmallReview(int index) {
    return Container(
      margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
      padding: EdgeInsets.all(getProportionateScreenHeight(8)),
      height: getProportionateScreenWidth(48),
      width: getProportionateScreenWidth(48),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all()),
      child: Image.network(imageNetwork + product.pictures[index]),
    );
  }
}
