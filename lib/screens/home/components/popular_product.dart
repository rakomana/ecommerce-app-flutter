import 'package:flutter/material.dart';
//import 'package:flutter_shop/components/product_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_shop/components/product_card.dart';
import 'package:flutter_shop/models/Product.dart';
import 'package:flutter_shop/api/products.dart';

import '../../../size_config.dart';
import '../../../constants.dart';
import 'section_title.dart';
import 'dart:convert';

class PopularProducts extends StatelessWidget {
  Future getProducts() async {
    var res = await CallApiProduct().products('products');
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
          images: u['image'],
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
      print(demoProducts.length);
      return demoProducts;
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
      Card(
        child: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else
              return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  itemCount: snapshot.data.length,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
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
                                      child: Image.network(
                                        imageNetwork + snapshot.data[index].images,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: IconButton(
                                              icon: Icon(Icons.favorite_border),
                                              onPressed: () {
                                              },
                                            ),
                                          ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  snapshot.data[index].title,
                                  maxLines: 2,
                                  style:
                                      TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                if (snapshot.data[index].rating != null)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          snapshot.data[index].rating.toString(),
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
                                    style: TextStyle(fontSize: 32, fontFamily: 'avenir')),
                              ],
                            ),
                          ),
                        );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1));
            /*
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1.02,
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(20)),
                              decoration: BoxDecoration(
                                color: kSecondaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Hero(
                                tag: snapshot.data[i].id.toString(),
                                child: Image.network(
                                    imageNetwork + snapshot.data[i].images),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data[i].title,
                            style: TextStyle(color: Colors.black),
                            maxLines: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\R${snapshot.data[i].newPrice}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(
                                      getProportionateScreenWidth(8)),
                                  height: getProportionateScreenWidth(28),
                                  width: getProportionateScreenWidth(28),
                                  decoration: BoxDecoration(
                                    color: snapshot.data[i].isFavourite
                                        ? kPrimaryColor.withOpacity(0.15)
                                        : kSecondaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/Heart Icon_2.svg",
                                    color: snapshot.data[i].isFavourite
                                        ? Color(0xFFFF4848)
                                        : Color(0xFFDBDEE4),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });*/
          },
        ),
      ),
    ]);
    /*return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Popular Products",
              press: () {
                getProducts();
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular)
                    return ProductCard(product: demoProducts[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );*/
  }
}
