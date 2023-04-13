import 'package:flutter/material.dart';
import 'package:mobile_app_exam/provider/product_provider.dart';
import 'package:mobile_app_exam/widgets/product_grid.dart';
import 'package:provider/provider.dart';

class ProductListViewWidget extends StatelessWidget {
  const ProductListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = context.watch<ProductProvider>();
    final productList = productData.productList;
    final searchProductListResult = productData.searchProductResult;

    return ProductGrid(
      productList: searchProductListResult.isNotEmpty
          ? searchProductListResult
          : productList,
    );
  }
}
