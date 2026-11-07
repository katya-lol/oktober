import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/products.dart';
import '../../models/product.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/cart_icon.dart';
import '../../widgets/category_button.dart';
import '../../widgets/product_card.dart';
import '../cart/cart_page.dart';
import '../product_details/product_details_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedCategory = 'Все';
  final Map<int, int> cart = {};
  final List<String> categories = ['Все', 'Пицца', 'Кебаб', 'Бургер'];

  int get cartCount => cart.values.fold(0, (sum, quantity) => sum + quantity);

  List<Product> get visibleProducts {
    if (selectedCategory == 'Все') return products;
    return products.where((product) => product.category == selectedCategory).toList();
  }

  void addToCart(Product product) {
    setState(() {
      cart[product.id] = (cart[product.id] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.name} добавлен в корзину'),
          duration: const Duration(seconds: 1),
          backgroundColor: primaryText,
        ),
      );
  }

  void openCart() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CartPage(
          cart: Map<int, int>.from(cart),
          onCartChanged: (updatedCart) {
            setState(() {
              cart
                ..clear()
                ..addAll(updatedCart);
            });
          },
        ),
      ),
    );
  }

  void _showDrawerMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
          backgroundColor: primaryText,
        ),
      );
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: 'Alt.Point',
      applicationVersion: '1.0.0',
      applicationLegalese: 'Учебный проект мобильного приложения',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appBg,
      drawer: AppDrawer(
        onMessage: _showDrawerMessage,
        onAbout: _showAbout,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: 'Открыть меню',
                          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.menu, size: 26, color: primaryText),
                        ),
                        const SizedBox(width: 22),
                        const Text(
                          'Челябинск',
                          style: TextStyle(fontSize: 16, color: primaryText),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_down, size: 21),
                        const Spacer(),
                        CartIcon(count: cartCount, onTap: openCart),
                      ],
                    ),
                    const SizedBox(height: 42),
                    const Text(
                      'Голоден?',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: primaryText,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Row(
                      children: [
                        Icon(Icons.search, color: primaryText, size: 23),
                        SizedBox(width: 18),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Поиск по меню',
                              hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontSize: 15),
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 27),
                    Row(
                      children: categories.map((category) {
                        return Expanded(
                          child: CategoryButton(
                            category: category,
                            selected: selectedCategory == category,
                            onTap: () => setState(() => selectedCategory = category),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = visibleProducts[index];
                  return ProductCard(
                    product: product,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => ProductDetailsPage(
                          product: product,
                          onBuy: () => addToCart(product),
                          onOpenCart: openCart,
                        ),
                      ),
                    ),
                    onBuy: () => addToCart(product),
                  );
                },
                childCount: visibleProducts.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}
