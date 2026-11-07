import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../models/product.dart';
import '../../widgets/circle_action.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.onBuy,
    required this.onOpenCart,
  });

  final Product product;
  final VoidCallback onBuy;
  final VoidCallback onOpenCart;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool favorite = false;
  String selectedTab = 'Дополнительно';

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: appBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      Image.asset(product.image, width: double.infinity, height: 285, fit: BoxFit.cover),
                      Positioned(
                        top: 14,
                        left: 16,
                        child: CircleAction(icon: Icons.arrow_back, onTap: () => Navigator.pop(context)),
                      ),
                      Positioned(
                        top: 14,
                        right: 16,
                        child: CircleAction(icon: Icons.shopping_cart_outlined, onTap: widget.onOpenCart),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: primaryText)),
                              const SizedBox(height: 7),
                              const Row(
                                children: [
                                  Icon(Icons.star_border, size: 17),
                                  SizedBox(width: 3),
                                  Text('4,5', style: TextStyle(fontWeight: FontWeight.w600)),
                                  SizedBox(width: 10),
                                  Text('(100+)', style: TextStyle(color: secondaryText)),
                                  SizedBox(width: 12),
                                  Text('25-30 мин'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text('₽${product.price}', style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w700, color: primaryText)),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: () => setState(() => favorite = !favorite),
                          icon: Icon(favorite ? Icons.favorite : Icons.favorite_border,
                            color: favorite ? Colors.redAccent : primaryText),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: ['Дополнительно', 'Похожие', 'Отзывы'].map((tab) {
                      final isSelected = selectedTab == tab;
                      return Expanded(
                        child: InkWell(
                          onTap: () => setState(() => selectedTab = tab),
                          child: Column(
                            children: [
                              Text(tab, style: TextStyle(fontSize: 13,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                                color: isSelected ? primaryText : secondaryText)),
                              const SizedBox(height: 9),
                              Container(height: 2, color: isSelected ? primaryText : Colors.transparent),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      selectedTab == 'Дополнительно'
                          ? product.description
                          : selectedTab == 'Похожие'
                              ? 'Попробуйте и другие блюда из нашего меню.'
                              : 'Оценка блюда — 4,5 из 5 на основе отзывов покупателей.',
                      style: const TextStyle(fontSize: 14, height: 1.5, color: primaryText),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: appBg,
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: widget.onBuy,
                  style: FilledButton.styleFrom(
                    backgroundColor: accentYellow,
                    foregroundColor: primaryText,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: const Text('Купить', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
