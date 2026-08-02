import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/model/new_user_model.dart';
import 'package:my_app/model/user_model.dart';

class UserService {
  static const String url = "https://api.escuelajs.co/api/v1/users/";

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    }
    throw Exception("Failed to get users");
  }

  Future<NewUserModel> createUser(NewUserModel newUser) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newUser.toJson()),
    );

    if (response.statusCode == 201||response.statusCode == 200) {
      return NewUserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }
}
