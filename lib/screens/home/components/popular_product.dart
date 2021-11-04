import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_shop/screens/details/details_screen.dart';
import 'package:flutter_shop/models/Product.dart';
import 'package:flutter_shop/api/products.dart';

import '../../../size_config.dart';
import '../../../constants.dart';
import 'section_title.dart';
import 'dart:convert';

class PopularProducts extends StatelessWidget {
  PopularProducts(this.value);

  final String value;

  Future getProducts(BuildContext context) async {
    await checkInternetAccess(context);

    var res = await CallApiProduct().products('products');
    var body = json.decode(res.body);
    var item = body['items'];
    List<Product> rawProducts = [];
    List products;

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

        //add products to the list
        rawProducts.add(product);
      }
      //query list based on category
      if (value == 'Nil') {
        products = rawProducts;
      } else {
        products = rawProducts.where((element) => element.category == value).toList();

        if(products.isEmpty)
        {
          products = rawProducts.where((element) => element.title.toLowerCase().contains(value.toLowerCase())
        ).toList();
        }
      }

      return products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SectionTitle(title: "Popular Products", press: () {}),
      ),
      SizedBox(height: getProportionateScreenWidth(20)),
      FutureBuilder(
        future: getProducts(context),
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
                  child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      itemCount: snapshot.data.length,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                product: snapshot.data[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          imageNetwork +
                                              snapshot.data[index].images,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                          icon: Icon(Icons.favorite_border),
                                          onPressed: () {},
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  snapshot.data[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'avenir',
                                      fontWeight: FontWeight.w800),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                if (snapshot.data[index].rating != null)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          snapshot.data[index].rating
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 8),
                                Text('\R${snapshot.data[index].newPrice}',
                                    style: TextStyle(
                                        fontSize: 32, fontFamily: 'avenir')),
                              ],
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
                ),
              ],
            );
        },
      ),
    ]);
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
      //display no internet connection dialog
      showMyDialog(context);
    }
  }
}
