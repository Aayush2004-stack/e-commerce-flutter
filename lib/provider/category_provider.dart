import 'package:flutter/widgets.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/model/create_category_model.dart';
import 'package:my_app/services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _apiService = CategoryService();

  List<CategoryModel> _categories = [];

  bool isLoading = false;

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      _categories = await _apiService.fetchCategories();
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  List<CategoryModel> get categories => List.unmodifiable(_categories);

  Future<void> createCategory(CreateCategoryModel category) async {
    isLoading = true;
    notifyListeners();

    try {
      await _apiService.createCategory(category);
      await getCategories(); // Refresh the categories after creating a new one
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> deleteCategory(int categoryId) async {
    isLoading = true;
    notifyListeners();
    bool isDeleted = false;

    try {
      await _apiService.deleteCategory(categoryId);
      isDeleted = true;
      await getCategories(); // Refresh the categories after deletion
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return isDeleted;
  }

  Future<bool> updateCategory(
    int categoryId,
    CreateCategoryModel updatedCategory,
  ) async {
    isLoading = true;
    notifyListeners();
    bool isUpdated = false;

    try {
      await _apiService.updateCategory(categoryId, updatedCategory);
      isUpdated = true;
      await getCategories(); // Refresh the categories after updating
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return isUpdated;
  }
}
