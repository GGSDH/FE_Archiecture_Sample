import 'package:architecture_sample/data/datasource/todo_datasource.dart';
import 'package:dio/dio.dart';

import '../dio_client.dart';
import '../model/todo.dart';

class TodoDataSourceImpl extends TodoDataSource {
  final DioClient dioClient;
  TodoDataSourceImpl({required this.dioClient});

  @override
  Future<List<Todo>> getTodos() {
    return dioClient.getTodoList();
  }

  @override
  Future<Response> addTodo({
    required String content
  }) {
    return dioClient.addTodo(
      content: content
    );
  }

  @override
  Future<Response> deleteTodo({
    required String id
  }) {
    return dioClient.deleteTodo(
      id: id
    );
  }
}