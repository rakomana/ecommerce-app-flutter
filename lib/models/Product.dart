import 'package:flutter/material.dart';

class Product {
  Product({
    this.id,
    this.title,
    this.description,
    this.oldPrice,
    this.newPrice,
    this.quantity,
    this.images,
    this.status,
    this.name,
    this.category,
    this.colors,
    this.rating = 0.0,
  });

  int id;
  String title;
  String description;
  String oldPrice;
  String newPrice;
  String quantity;
  String images;
  String status;
  String name;
  String category;
  final double rating;
  final List<Color> colors;
}

