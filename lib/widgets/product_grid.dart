import 'package:flutter/material.dart';
import 'package:mobile_app_exam/models/product.dart';
import 'package:mobile_app_exam/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> productList;

  const ProductGrid({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 2 / 3, crossAxisSpacing: 20),
      itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
        // create: (BuildContext context) => products[idx],
        value: productList[idx],
        child: const ProductItem(),
      ),
      itemCount: productList.length,
      padding: const EdgeInsets.all(10),
    );
  }
}
