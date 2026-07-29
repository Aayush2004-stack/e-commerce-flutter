import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/model/new_product_model.dart';
import 'package:my_app/model/product_cart_model.dart';
import 'package:my_app/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _apiService = ProductService();

  List<NewProductModel> _products = [];

  bool isLoading = false;

  Future<void> getProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  final List<NewProductModel> _wishlist = [];
  final List<ProductCartModel> _cartList = [];

  List<NewProductModel> get products => List.unmodifiable(_products);
  List<NewProductModel> get wishlistItems => List.unmodifiable(_wishlist);
  List<ProductCartModel> get cartItems => List.unmodifiable(_cartList);

  // void addProduct(NewProductModel product) {
  //   _products.add(product);
  //   notifyListeners();
  // }

  // void addProductFromFields({
  //   required String name,
  //   required String imageUrl,
  //   required double price,
  //   double? oldPrice,
  //   required double rating,
  //   required String category,
  // }) {
  //   addProduct(
  //     ProductModel(
  //       id: DateTime.now().microsecondsSinceEpoch.toString(),
  //       name: name,
  //       imageUrl: imageUrl,
  //       price: price,
  //       oldPrice: oldPrice,
  //       rating: rating,
  //       category: category,
  //     ),
  //   );
  // }

  void removeProduct(String id) {
    _products.removeWhere((product) => product.id.toString() == id);
    _wishlist.removeWhere((product) => product.id.toString() == id);
    notifyListeners();
  }

  void clearList() {
    _products.clear();
    _wishlist.clear();
    notifyListeners();
  }

  void toggleWishlist(NewProductModel product) {
    final exist = _wishlist.any((item) => item.id == product.id);

    if (exist) {
      _wishlist.removeWhere((item) => item.id == product.id);
    } else {
      _wishlist.add(product);
    }
    notifyListeners();
  }

  bool isInWishlist(String id) {
    return _wishlist.any((product) => product.id.toString() == id);
  }

  void addProductInCart(ProductCartModel product) {
    final exist = _cartList.any(
      (item) => item.product.id == product.product.id,
    );
    if (!exist) {
      _cartList.add(product);
      notifyListeners();
    }
  }

  bool isInCartlist(String id) {
    return _cartList.any((cart) => cart.product.id.toString() == id);
  }

  void removeProductFromCart(ProductCartModel product) {
    final exist = _cartList.any(
      (item) => item.product.id == product.product.id,
    );
    if (exist) {
      _cartList.remove(product);
      notifyListeners();
    }
  }

  void addQuantity(ProductCartModel product) {
    product.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(ProductCartModel product) {
    if (product.quantity > 1) {
      product.quantity--;
    } else {
      removeProductFromCart(product);
    }
    notifyListeners();
  }

  ProductCartModel getProduct(String id) {
    return cartItems.firstWhere(
      (product) => product.product.id.toString() == id,
    );
  }

  String getTotalProductByCategory(CategoryModel category) {
    int numberOfProducts = 0;
    for (final product in products) {
      if (product.category.id == category.id) {
        numberOfProducts++;
      }
    }

    return "$numberOfProducts";
  }

  // void clearWishlist() {

  // }
}
