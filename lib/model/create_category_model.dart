// To parse this JSON data, do
//
//     final createCategoryModel = createCategoryModelFromJson(jsonString);

import 'dart:convert';

CreateCategoryModel createCategoryModelFromJson(String str) => CreateCategoryModel.fromJson(json.decode(str));

String createCategoryModelToJson(CreateCategoryModel data) => json.encode(data.toJson());

class CreateCategoryModel {
    String name;
    String image;

    CreateCategoryModel({
        required this.name,
        required this.image,
    });

    factory CreateCategoryModel.fromJson(Map<String, dynamic> json) => CreateCategoryModel(
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
    };
}
