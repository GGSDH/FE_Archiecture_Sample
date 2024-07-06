import 'package:architecture_sample/data/repository/todo_repository.dart';
import 'package:dio/dio.dart';

import '../datasource/todo_datasource.dart';
import '../model/todo.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoDataSource todoDataSource;
  TodoRepositoryImpl({required this.todoDataSource});

  @override
  Future<List<Todo>> getTodos() {
    return todoDataSource.getTodos();
  }

  @override
  Future<Response> addTodo({
    required String content
  }) {
    return todoDataSource.addTodo(
      content: content
    );
  }
}