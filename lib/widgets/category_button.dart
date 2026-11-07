import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final String category;
  final bool selected;
  final VoidCallback onTap;

  IconData get icon {
    switch (category) {
      case 'Пицца':
        return Icons.local_pizza_outlined;
      case 'Кебаб':
        return Icons.kebab_dining;
      case 'Бургер':
        return Icons.lunch_dining_outlined;
      default:
        return Icons.room_service_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Icon(icon, size: 30, color: primaryText),
            const SizedBox(height: 8),
            Text(
              category,
              style: TextStyle(
                color: primaryText,
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 26,
              height: 2,
              color: selected ? primaryText : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
