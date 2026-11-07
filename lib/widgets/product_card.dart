import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onBuy,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Image.asset(
              product.image,
              height: 165,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 165,
                color: const Color(0xFFE6E6E6),
                child: const Icon(Icons.fastfood, size: 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 13, 23, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: primaryText,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Row(
                          children: [
                            Icon(Icons.star_border, size: 16, color: primaryText),
                            SizedBox(width: 3),
                            Text('4,5', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            SizedBox(width: 8),
                            Text('(100+)', style: TextStyle(fontSize: 13, color: secondaryText)),
                            SizedBox(width: 10),
                            Text('25-30 мин', style: TextStyle(fontSize: 13, color: primaryText)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: '₽', style: TextStyle(fontSize: 14, color: secondaryText)),
                      TextSpan(
                        text: '${product.price}',
                        style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w700, color: primaryText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 15, 23, 24),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: FilledButton(
                onPressed: onBuy,
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
    );
  }
}
