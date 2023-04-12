import 'package:flutter/material.dart';
import 'package:mobile_app_exam/provider/product_provider.dart';
import 'package:mobile_app_exam/widgets/product_grid.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<StatefulWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    context.read<ProductProvider>().fetchProductList().then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : const ProductGrid());
  }
}
