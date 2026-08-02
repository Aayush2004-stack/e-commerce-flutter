import 'dart:convert';

import 'package:http/http.dart' as http;
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
}
