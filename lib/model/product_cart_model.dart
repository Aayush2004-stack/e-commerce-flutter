import 'package:my_app/model/new_product_model.dart';


class ProductCartModel {
final NewProductModel product;
// final ProductModel product;
 int quantity;

 ProductCartModel({required this.product,  this.quantity=1});


}