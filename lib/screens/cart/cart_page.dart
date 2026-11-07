import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/products.dart';
import '../../models/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.cart, required this.onCartChanged});
  final Map<int, int> cart;
  final ValueChanged<Map<int, int>> onCartChanged;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Map<int, int> quantities;

  @override
  void initState() {
    super.initState();
    quantities = Map<int, int>.from(widget.cart);
  }

  int get totalCount => quantities.values.fold(0, (sum, count) => sum + count);
  int get totalPrice => products.fold(0, (sum, product) => sum + product.price * (quantities[product.id] ?? 0));

  void changeQuantity(Product product, int delta) {
    setState(() {
      final newValue = (quantities[product.id] ?? 0) + delta;
      if (newValue <= 0) {
        quantities.remove(product.id);
      } else {
        quantities[product.id] = newValue;
      }
    });
    widget.onCartChanged(Map<int, int>.from(quantities));
  }

  @override
  Widget build(BuildContext context) {
    final items = products.where((product) => (quantities[product.id] ?? 0) > 0).toList();
    return Scaffold(
      backgroundColor: appBg,
      appBar: AppBar(
        backgroundColor: appBg,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Корзина', style: TextStyle(color: primaryText, fontWeight: FontWeight.w600)),
        centerTitle: false,
      ),
      body: items.isEmpty
          ? const Center(child: Text('Корзина пока пуста', style: TextStyle(fontSize: 16, color: secondaryText)))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final product = items[index];
                      final quantity = quantities[product.id] ?? 0;
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(product.image, width: 76, height: 76, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(product.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                              const SizedBox(height: 6),
                              Text('₽${product.price}', style: const TextStyle(color: secondaryText)),
                            ])),
                            IconButton(onPressed: () => changeQuantity(product, -1), icon: const Icon(Icons.remove_circle_outline)),
                            Text('$quantity', style: const TextStyle(fontWeight: FontWeight.w700)),
                            IconButton(onPressed: () => changeQuantity(product, 1), icon: const Icon(Icons.add_circle_outline)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Товаров: $totalCount'),
                      Text('Итого: ₽$totalPrice', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    ]),
                    const SizedBox(height: 14),
                    SizedBox(width: double.infinity, height: 46, child: FilledButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Оформление заказа пока не подключено')),
                      ),
                      style: FilledButton.styleFrom(backgroundColor: accentYellow, foregroundColor: primaryText, shape: const StadiumBorder(), elevation: 0),
                      child: const Text('Оформить заказ'),
                    )),
                  ]),
                ),
              ],
            ),
    );
  }
}
