import 'package:flutter/cupertino.dart';

import '../../data/model/todo.dart';
import '../../data/repository/todo_repository.dart';

class TodoListViewModel extends ChangeNotifier {
  late TodoRepository todoRepository;

  TodoListViewModel({required this.todoRepository});

  List<Todo> get items => _items;
  bool get isLoading => _isLoading;

  List<Todo> _items = [];
  bool _isLoading = false;

  Future<void> getTodos() async {
    _isLoading = true;
    notifyListeners();

    _items = await todoRepository.getTodos();

    _isLoading = false;
    notifyListeners();
  }
}