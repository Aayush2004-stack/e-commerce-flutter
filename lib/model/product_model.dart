class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final double rating;
  final String category;

  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.category,
  });
}
