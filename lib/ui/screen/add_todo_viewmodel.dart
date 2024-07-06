import 'package:architecture_sample/data/repository/todo_repository.dart';
import 'package:flutter/cupertino.dart';

class AddTodoViewModel extends ChangeNotifier {
  late TodoRepository todoRepository;

  AddTodoViewModel({required this.todoRepository});

  Future<void> addTodo({
    required String content,
  }) async {
    await todoRepository.addTodo(
      content: content
    );
    notifyListeners();
  }
}