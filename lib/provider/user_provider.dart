import 'package:flutter/widgets.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/services/user_service.dart';

class UserProvider extends ChangeNotifier{

  final UserService _userService =UserService();
  List<UserModel> _users=[];
  bool isLoading= false;

  Future<void> getUsers() async{
    isLoading=true;
    notifyListeners();

    try{
      _users=await _userService.fetchUsers();
    }
    catch(e){
      debugPrint(e.toString());

    }
    finally{
      isLoading=false;
      notifyListeners();
    }


  }
  List<UserModel> get users=> List.unmodifiable(_users);

}