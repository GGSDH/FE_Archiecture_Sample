import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'model/todo.dart';

class DioClient {
  late final Dio _dio;

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
      final Map<String, dynamic> data = response.data;
      data.forEach((key, value) {
        todoList.add(Todo(
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
            'content': content,
          })
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}