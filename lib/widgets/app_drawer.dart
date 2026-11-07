import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.onMessage,
    required this.onAbout,
  });

  final ValueChanged<String> onMessage;
  final VoidCallback onAbout;

  void _closeAndShowMessage(BuildContext context, String message) {
    Navigator.pop(context);
    onMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: accentYellow,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.restaurant_menu, size: 34, color: primaryText),
                  SizedBox(height: 12),
                  Text(
                    'Alt.Point',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Доставка любимых блюд',
                    style: TextStyle(fontSize: 14, color: primaryText),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Главная'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Мои заказы'),
              onTap: () => _closeAndShowMessage(
                context,
                'История заказов пока не подключена',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Избранное'),
              onTap: () => _closeAndShowMessage(
                context,
                'Раздел «Избранное» пока не подключён',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: const Text('Адрес доставки'),
              subtitle: const Text('Челябинск'),
              onTap: () => _closeAndShowMessage(
                context,
                'Выбор адреса будет добавлен позже',
              ),
            ),
            const Divider(height: 24),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('О приложении'),
              onTap: () {
                Navigator.pop(context);
                onAbout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
