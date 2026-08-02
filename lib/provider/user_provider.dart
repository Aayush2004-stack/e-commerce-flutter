import 'package:flutter/widgets.dart';
import 'package:my_app/model/new_user_model.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  final List<UserModel> _users = [];
  bool isLoading = false;

  Future<void> getUsers() async {
    isLoading = true;
    notifyListeners();

    try {
      final remoteUsers = await _userService.fetchUsers();
      _users.clear();
      _users.addAll(remoteUsers);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<UserModel> get users => List.unmodifiable(_users);

  Future<NewUserModel?> createUser(NewUserModel user) async {
    isLoading = true;
    notifyListeners();

    try {
      final createdUser = await _userService.createUser(user);

      _users.insert(
        0,
        UserModel(
          id: DateTime.now().millisecondsSinceEpoch,
          email: createdUser.email,
          password: createdUser.password,
          name: createdUser.name,
          role: 'customer',
          avatar: createdUser.avatar,
          creationAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      return createdUser;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
