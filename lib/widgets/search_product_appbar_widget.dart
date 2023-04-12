import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app_exam/provider/product_provider.dart';
import 'package:provider/provider.dart';

class SearchProductAppbarWidget extends StatefulWidget {
  const SearchProductAppbarWidget({Key? key}) : super(key: key);

  @override
  State<SearchProductAppbarWidget> createState() =>
      _SearchProductAppbarWidget();
}

class _SearchProductAppbarWidget extends State<SearchProductAppbarWidget>
    with SingleTickerProviderStateMixin {
  bool _isActive = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChange(String keyword) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      context.read<ProductProvider>().searchProductByName(keyword);
    });
  }

  void _onCloseSearchBar() {
    context.read<ProductProvider>().resetSearch();
    setState(() {
      _isActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!_isActive)
          Text("Shopping mall",
              style: Theme.of(context).appBarTheme.titleTextStyle),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: _isActive
                  ? Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search for products',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: _onCloseSearchBar,
                                icon: const Icon(Icons.close))),
                        onChanged: _onSearchChange,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _isActive = true;
                        });
                      },
                      icon: const Icon(Icons.search)),
            ),
          ),
        ),
      ],
    );
  }
}
