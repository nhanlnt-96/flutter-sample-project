import 'package:flutter/material.dart';
import 'package:mobile_app_exam/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartWidgetAppbar extends StatelessWidget {
  const CartWidgetAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Cart'),
        Text(
          '${context.watch<ProductProvider>().cartList.length} items',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartData = context.watch<ProductProvider>().cartList;
    final productProvider = context.read<ProductProvider>();

    void removeProductFromCart(int index) {
      final productData = cartData[index];
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Remove from cart'),
                content: Text(
                    'You are going to remove ${productData.title} from cart. Are you sure?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () {
                        productProvider.removeFromCart(index);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Removed ${productData.title} from cart'),
                            duration: const Duration(seconds: 2)));
                      },
                      child: const Text('Yes'))
                ],
              ));
    }

    void checkoutCart() {
      if (cartData.isNotEmpty) {
        productProvider.clearCart();
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Checkout'),
                  content: const Text('Checkout successful. Thank you.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK')),
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Checkout'),
                  content: const Text(
                      'Do not have any item in cart. Please add at least one item to cart before checkout.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK')),
                  ],
                ));
      }
    }

    return Scaffold(
      body: Column(
        children: [
          cartData.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    itemCount: cartData.length,
                    itemBuilder: (_, index) => Row(
                      children: [
                        SizedBox(
                          width: 125,
                          child: AspectRatio(
                            aspectRatio: .95,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                cartData[index].image,
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
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData[index].title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '\$${cartData[index].price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => removeProductFromCart(index),
                          color: Colors.red,
                        )
                      ],
                    ),
                    separatorBuilder: (_, index) => const SizedBox(
                      height: 16,
                    ),
                  ),
                )
              : const Expanded(
                  child: Center(
                    child: Text('Your cart is empty'),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '\$${context.watch<ProductProvider>().totalCart.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: checkoutCart,
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.blue)))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text('Checkout'),
                  ),
                  // minSize: const Size(220, 45),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
