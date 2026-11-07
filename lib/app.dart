import 'package:flutter/material.dart';

import 'core/app_colors.dart';
import 'screens/catalog/catalog_page.dart';

class AltPointApp extends StatelessWidget {
  const AltPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alt.Point',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: appBg,
        colorScheme: ColorScheme.fromSeed(seedColor: accentYellow),
        fontFamily: 'Roboto',
      ),
      home: const CatalogPage(),
    );
  }
}
