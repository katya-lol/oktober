import 'package:flutter/material.dart';

void main() => runApp(const AltPointApp());

const Color appBg = Color(0xFFF2F2F2);
const Color accentYellow = Color(0xFFF6CF4D);
const Color primaryText = Color(0xFF303030);
const Color secondaryText = Color(0xFF8A8A8A);

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    this.price = 300,
    this.description = 'Вкусное блюдо из свежих ингредиентов.',
  });

  final int id;
  final String name;
  final String category;
  final String image;
  final int price;
  final String description;
}

const List<Product> products = [
  Product(
    id: 1,
    name: 'Дерзкая Марго',
    category: 'Пицца',
    image: 'assets/images/margherita.jpg',
    description: 'Ароматная пицца с сыром и сочной начинкой.',
  ),
  Product(
    id: 2,
    name: 'Горячий парень',
    category: 'Кебаб',
    image: 'assets/images/hot_guy.jpg',
    description: 'Сытное горячее блюдо с мясом и свежей зеленью.',
  ),
  Product(
    id: 3,
    name: 'Вкусняшка Миа',
    category: 'Все',
    image: 'assets/images/mia_snack.jpg',
    description: 'Лёгкое блюдо для вкусного обеда.',
  ),
  Product(
    id: 4,
    name: 'Сытый Питт',
    category: 'Бургер',
    image: 'assets/images/satiy_pitt.jpg',
    description: 'Сочный бургер с картофелем фри и соусом.',
  ),
];

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

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  void _showDrawerMessage(String message) {
    _closeDrawer();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appBg,
      drawer: Drawer(
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
                onTap: _closeDrawer,
              ),
              ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text('Мои заказы'),
                onTap: () => _showDrawerMessage('История заказов пока не подключена'),
              ),
              ListTile(
                leading: const Icon(Icons.favorite_border),
                title: const Text('Избранное'),
                onTap: () => _showDrawerMessage('Раздел «Избранное» пока не подключён'),
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Адрес доставки'),
                subtitle: const Text('Челябинск'),
                onTap: () => _showDrawerMessage('Выбор адреса будет добавлен позже'),
              ),
              const Divider(height: 24),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('О приложении'),
                onTap: () {
                  _closeDrawer();
                  showAboutDialog(
                    context: context,
                    applicationName: 'Alt.Point',
                    applicationVersion: '1.0.0',
                    applicationLegalese: 'Учебный проект мобильного приложения',
                  );
                },
              ),
            ],
          ),
        ),
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
                          cartCount: cartCount,
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

class CartIcon extends StatelessWidget {
  const CartIcon({super.key, required this.count, required this.onTap});
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Center(child: Icon(Icons.shopping_cart_outlined, size: 25, color: primaryText)),
            if (count > 0)
              Positioned(
                right: -1,
                top: -3,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: accentYellow, shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  child: Text('$count', textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.cartCount,
    required this.onBuy,
    required this.onOpenCart,
  });

  final Product product;
  final int cartCount;
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
                        child: _CircleAction(icon: Icons.arrow_back, onTap: () => Navigator.pop(context)),
                      ),
                      Positioned(
                        top: 14,
                        right: 16,
                        child: _CircleAction(icon: Icons.shopping_cart_outlined, onTap: widget.onOpenCart),
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

class _CircleAction extends StatelessWidget {
  const _CircleAction({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.92),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(width: 42, height: 42, child: Icon(icon, color: primaryText)),
      ),
    );
  }
}

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
