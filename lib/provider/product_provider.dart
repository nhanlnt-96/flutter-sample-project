import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app_exam/models/product.dart';
import 'package:http/http.dart' as http_client;

class ProductProvider with ChangeNotifier {
  final String productApiEndpoint = 'https://fakestoreapi.com/products';
  List<Product> _productList = [];
  List<Product> _searchProductResult = [];
  final List<Product> _wishList = [];
  List<Product> _cartList = [];

  List<Product> get productList {
    return [..._productList];
  }

  List<Product> get searchProductResult {
    return [..._searchProductResult];
  }

  List<Product> get productWishList {
    return [..._wishList];
  }

  List<Product> get cartList {
    return [..._cartList];
  }

  double get totalCart {
    double total = 0.0;
    if (_cartList.isNotEmpty) {
      for (var item in _cartList) {
        total += item.price;
      }
    }

    return total;
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

  Product findById(int productId) {
    return _productList.firstWhere((product) => product.productId == productId);
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

  bool checkProductInWishListData(int productId) {
    return _wishList
        .where((product) => product.productId == productId)
        .isNotEmpty;
  }

  void addToWishList(int productId) {
    final productData = findById(productId);
    if (checkProductInWishListData(productId)) {
      _wishList.removeWhere((product) => product.productId == productId);
    } else {
      _wishList.add(Product(
          productId: productData.productId,
          title: productData.title,
          price: productData.price,
          description: productData.description,
          category: productData.category,
          image: productData.image));
    }

    notifyListeners();
  }

  void addToCart(int productId) {
    final productData = findById(productId);
    _cartList.add(Product(
        productId: productData.productId,
        title: productData.title,
        price: productData.price,
        description: productData.description,
        category: productData.category,
        image: productData.image));

    notifyListeners();
  }

  void removeFromCart(int productIndex) {
    _cartList.removeAt(productIndex);

    notifyListeners();
  }

  void clearCart() {
    _cartList = [];
    notifyListeners();
  }
}
