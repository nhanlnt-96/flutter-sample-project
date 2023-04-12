import 'package:flutter/material.dart';
import 'package:mobile_app_exam/provider/product_provider.dart';
import 'package:mobile_app_exam/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = context.watch<ProductProvider>();
    final productList = productData.productList;
    final searchProductListResult = productData.searchProductResult;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 2 / 3, crossAxisSpacing: 20),
      itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
        // create: (BuildContext context) => products[idx],
        value: searchProductListResult.isNotEmpty
            ? searchProductListResult[idx]
            : productList[idx],
        child: const ProductItem(),
      ),
      itemCount: searchProductListResult.isNotEmpty
          ? searchProductListResult.length
          : productList.length,
      padding: const EdgeInsets.all(10),
    );
  }
}
