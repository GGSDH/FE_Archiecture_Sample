import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uuid/uuid.dart';

import 'model/todo.dart';

class DioClient {
  late final Dio _dio;
  final Uuid _uuid = const Uuid();

  DioClient() {
    final options = BaseOptions(
      contentType: Headers.jsonContentType,
      baseUrl: 'https://samplearchitecture-b2897-default-rtdb.firebaseio.com/',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    );

    _dio = Dio(options)
    ..httpClientAdapter = IOHttpClientAdapter()
    ..interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true
      )
    ]);
  }

  Future<List<Todo>> getTodoList() async {
    try {
      final Response response = await _dio.get('/todo-list.json');
      final List<Todo> todoList = [];
      final Map<String, dynamic>? data = response.data;
      data?.forEach((key, value) {
        todoList.add(Todo(
          id: value['id'],
          content: value['content'],
        ));
      });
      return todoList;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> addTodo({
    required String content,
  }) async {
    try {
      final Response response = await _dio.post(
          '/todo-list.json',
          data: json.encode({
            'id': _uuid.v4(),
            'content': content,
          })
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> deleteTodo({
    required String id,
  }) async {
    try {
      final Response response = await _dio.delete(
          '/todo-list/$id.json'
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}