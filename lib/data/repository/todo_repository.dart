import 'package:dio/dio.dart';

import '../model/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<Response> addTodo({
    required String content,
  });
  Future<Response> deleteTodo({
    required String id,
  });
}