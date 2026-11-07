import '../models/product.dart';

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
