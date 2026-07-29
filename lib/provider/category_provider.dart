import 'package:flutter/widgets.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/services/category_service.dart';

class CategoryProvider extends ChangeNotifier{
  final CategoryService _apiService =CategoryService();

  List<CategoryModel> _categories =[];

  bool isLoading =false;

  Future<void> getCategories() async{
    isLoading = true;
    notifyListeners();

    try{
      _categories= await _apiService.fetchCategories();
      
    }
    catch(e){
      debugPrint(e.toString());
    }
    isLoading= false;
    notifyListeners();


  }

  List<CategoryModel> get categories => List.unmodifiable(_categories);


}