import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final int productId;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  Product(
      {required this.productId,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image});

  @override
  String toString() {
    return 'Product{productId: $productId, title: $title, price: $price, description: $description, category: $category, image: $image}';
  }
}
