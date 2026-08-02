
import 'package:flutter/material.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/model/create_product_model.dart';
import 'package:my_app/model/new_product_model.dart';
import 'package:my_app/services/product_service.dart';

class NewProductProvider extends ChangeNotifier {
  NewProductProvider({ProductService? apiService})
    : _apiService = apiService ?? ProductService();

  final ProductService _apiService;

  List<NewProductModel> products = [];
  List<CategoryModel> categories = [];

  bool isLoading = false;
  bool isCategoriesLoading = false;

  Future<void> getProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      products = await _apiService.fetchProducts();
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  
  Future<CreateProductModel?> createProduct(CreateProductModel product) async {
    isLoading = true;
    notifyListeners();

    try {
      final createdProduct = await _apiService.createProduct(product);
      products.add(
        NewProductModel(
          id: createdProduct.id ?? DateTime.now().millisecondsSinceEpoch,
          title: createdProduct.title,
          slug:
              createdProduct.slug ??
              createdProduct.title.toLowerCase().replaceAll(' ', '-'),
          price: createdProduct.price,
          description: createdProduct.description,
          category: CategoryModel(
            id: createdProduct.categoryId,
            name:
                createdProduct.categoryName ??
                'Category ${createdProduct.categoryId}',
            image: createdProduct.categoryImage ?? '',
            slug:
                createdProduct.categorySlug ??
                'category-${createdProduct.categoryId}',
          ),
          images: createdProduct.images,
        ),
      );
      return createdProduct;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

