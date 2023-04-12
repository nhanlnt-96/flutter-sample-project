import 'package:flutter/material.dart';
import 'package:mobile_app_exam/models/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = context.read<Product>();
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: .95,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                      loadingBuilder: (_, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const Center(
                                  child: CircularProgressIndicator()),
                      color: Colors.white,
                      colorBlendMode: BlendMode.multiply,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15, right: 15),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.withOpacity(0.8)),
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
                      hoverColor: Colors.white.withOpacity(0),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '\$${product.price.toString()}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            )
          ],
        ),
      ),
    );
  }
}
