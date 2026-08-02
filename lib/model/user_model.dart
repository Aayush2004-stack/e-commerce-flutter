// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int id;
    String email;
    String password;
    String name;
    String role;
    String avatar;
    DateTime creationAt;
    DateTime updatedAt;

    UserModel({
        required this.id,
        required this.email,
        required this.password,
        required this.name,
        required this.role,
        required this.avatar,
        required this.creationAt,
        required this.updatedAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
        "creationAt": creationAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
