import 'package:flutter/material.dart';
import 'package:mobile_app_exam/provider/product_provider.dart';
import 'package:mobile_app_exam/widgets/product_grid.dart';
import 'package:provider/provider.dart';

class WishListWidgetAppbar extends StatelessWidget {
  const WishListWidgetAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Wishlist'),
        Text(
          '${context.watch<ProductProvider>().productWishList.length} items',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}

class WishListWidget extends StatelessWidget {
  const WishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productWishListData =
        context.watch<ProductProvider>().productWishList;
    return productWishListData.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(24),
            child: ProductGrid(
              productList: productWishListData,
            ))
        : const Expanded(
            child: Center(
              child: Text('Your wishlist is empty'),
            ),
          );
  }
}
