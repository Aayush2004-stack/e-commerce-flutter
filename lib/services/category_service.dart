import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/model/category_model.dart';
import 'package:my_app/model/create_category_model.dart';

class CategoryService {
  static const String url = "https://api.escuelajs.co/api/v1/categories";
  static const String uploadUrl =
      "https://api.escuelajs.co/api/v1/files/upload";

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
          .map((e) => CategoryModel.fromJson(e))
          .toList()
          .reversed
          .toList();
    }
    throw Exception("Failed to get categories");
  }

  Future<CreateCategoryModel> createCategory(
    CreateCategoryModel category,
  ) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(category.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return CreateCategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create category');
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    final response = await http.delete(Uri.parse('$url/$categoryId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete category');
    }
  }

  Future<void> updateCategory(
    int categoryId,
    CreateCategoryModel updatedCategory,
  ) async {
    final response = await http.put(
      Uri.parse('$url/$categoryId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedCategory.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to update category');
    }
  }

  Future<String> uploadImage(File file) async {
    final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['location'];
    }

    throw Exception(
      "Failed to upload image: "
      "${response.statusCode} ${response.body}",
    );
  }
}
