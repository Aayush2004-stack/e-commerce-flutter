import 'package:flutter/material.dart';
import 'package:my_app/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todos = [];

  List<TodoModel> get todos => List.unmodifiable(_todos);

  //add todo
  void addTodo(String title) {
    _todos.add(TodoModel(id: DateTime.now().toIso8601String(), title: title));
    notifyListeners();
  }

  //toggle todo
  void toggleTodo(String id) {
    final todo = _todos.firstWhere((todo) => todo.id == id);

    todo.isCompleted = !todo.isCompleted;
    notifyListeners();
  }

  //clear list
  void clearList() {
    _todos.clear();
    notifyListeners();
  }

  //remove todo
  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);

    notifyListeners();
  }

  int get completedCount => _todos.where((todo) => todo.isCompleted).length;
  int get allTodos => _todos.length;
}
