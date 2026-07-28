import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final List<ProductModel> _products = [
    ProductModel(
      id: '1',
      name: 'Essence Organic Hoodie',
      imageUrl:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&q=80&w=400',
      price: 120.00,
      oldPrice: 165.00,
      rating: 4.9,
      category: 'Clothing',
    ),
    ProductModel(
      id: '2',
      name: 'Vanguard Chelsea Boots',
      imageUrl:
          'https://images.unsplash.com/photo-1638247025967-b4e38f787b76?auto=format&fit=crop&q=80&w=400',
      price: 245.00,
      oldPrice: 310.00,
      rating: 4.8,
      category: 'Accessories',
    ),
    ProductModel(
      id: '3',
      name: 'Archibald Wool Coat',
      imageUrl:
          'https://images.unsplash.com/photo-1539533377285-b82420a6e033?auto=format&fit=crop&q=80&w=400',
      price: 380.00,
      oldPrice: 450.00,
      rating: 5.0,
      category: 'Clothing',
    ),
    ProductModel(
      id: '4',
      name: 'Horizon Aviators',
      imageUrl:
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&q=80&w=400',
      price: 185.00,
      oldPrice: 215.00,
      rating: 4.7,
      category: 'Accessories',
    ),
    ProductModel(
      id: '5',
      name: 'Linen Weekend Shirt',
      imageUrl:
          'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?auto=format&fit=crop&q=80&w=400',
      price: 98.00,
      oldPrice: 125.00,
      rating: 4.6,
      category: 'Clothing',
    ),
    ProductModel(
      id: '6',
      name: 'Canvas Crossbody Bag',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=400',
      price: 142.00,
      oldPrice: 168.00,
      rating: 4.8,
      category: 'Accessories',
    ),
    ProductModel(
      id: '7',
      name: 'Everyday Sneakers',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=400',
      price: 160.00,
      oldPrice: 190.00,
      rating: 4.9,
      category: 'Accessories',
    ),
    ProductModel(
      id: '8',
      name: 'Minimal Knit Sweater',
      imageUrl:
          'https://images.unsplash.com/photo-1496747611176-843222e1e57c?auto=format&fit=crop&q=80&w=400',
      price: 134.00,
      oldPrice: 159.00,
      rating: 4.7,
      category: 'Clothing',
    ),
  ];

  final List<ProductModel> _wishlist = [];

  List<ProductModel> get products => List.unmodifiable(_products);
  List<ProductModel> get wishlistItems => List.unmodifiable(_wishlist);

  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  void addProductFromFields({
    required String name,
    required String imageUrl,
    required double price,
    double? oldPrice,
    required double rating,
    required String category,
  }) {
    addProduct(
      ProductModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        imageUrl: imageUrl,
        price: price,
        oldPrice: oldPrice,
        rating: rating,
        category: category,
      ),
    );
  }

  void removeProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    _wishlist.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  void clearList() {
    _products.clear();
    _wishlist.clear();
    notifyListeners();
  }

  // void toggleWishlist(ProductModel product) {
 
  // }

  // bool isInWishlist(String id) {
    
  // }

  // void clearWishlist() {

  // }
}
