// To parse this JSON data, do
//
//     final newUserModel = newUserModelFromJson(jsonString);

import 'dart:convert';

NewUserModel newUserModelFromJson(String str) => NewUserModel.fromJson(json.decode(str));

String newUserModelToJson(NewUserModel data) => json.encode(data.toJson());

class NewUserModel {
    String name;
    String email;
    String password;
    String avatar;

    NewUserModel({
        required this.name,
        required this.email,
        required this.password,
        required this.avatar,
    });

    factory NewUserModel.fromJson(Map<String, dynamic> json) => NewUserModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "avatar": avatar,
    };
}
