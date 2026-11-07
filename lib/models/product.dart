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
