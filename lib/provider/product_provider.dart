import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app_exam/models/product.dart';
import 'package:http/http.dart' as http_client;

class ProductProvider with ChangeNotifier {
  final String productApiEndpoint = 'https://fakestoreapi.com/products';
  List<Product> _productList = [];
  List<Product> _searchProductResult = [];

  List<Product> get productList {
    return [..._productList];
  }

  List<Product> get searchProductResult {
    return [..._searchProductResult];
  }

  Future<void> fetchProductList() async {
    try {
      final response = await http_client.get(Uri.parse(productApiEndpoint));
      final extractedData = jsonDecode(response.body) as List<dynamic>;

      List<Product> loadProduct = [];
      for (var product in extractedData) {
        loadProduct.add(Product(
            productId: product['id'],
            title: product['title'],
            price: product['price'],
            description: product['description'],
            category: product['category'],
            image: product['image']));
      }

      _productList = loadProduct;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void resetSearch() {
    _searchProductResult = [];

    notifyListeners();
  }

  void searchProductByName(String keyword) {
    if (keyword.isNotEmpty) {
      List<Product> result = productList
          .where((product) =>
              product.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();

      _searchProductResult = result;

      notifyListeners();
    } else {
      resetSearch();
    }
  }
}
