import 'package:flutter/material.dart';
import 'package:mobile_app_exam/provider/product_provider.dart';
import 'package:mobile_app_exam/widgets/cart_widget.dart';
import 'package:mobile_app_exam/widgets/home_widget.dart';
import 'package:mobile_app_exam/widgets/search_product_appbar_widget.dart';
import 'package:mobile_app_exam/widgets/wishlist_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _appBarTitle = <Widget>[
    SearchProductAppbarWidget(),
    CartWidgetAppbar(),
    WishListWidgetAppbar()
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    CartWidget(),
    WishListWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle.elementAt(_selectedIndex),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Badge(
                  label: Text(context
                      .watch<ProductProvider>()
                      .cartList
                      .length
                      .toString()),
                  child: const Icon(Icons.shopping_cart)),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Badge(
                  label: Text(context
                      .watch<ProductProvider>()
                      .productWishList
                      .length
                      .toString()),
                  child: const Icon(Icons.favorite)),
              label: 'Wishlist')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
