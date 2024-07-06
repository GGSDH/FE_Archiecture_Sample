import 'package:architecture_sample/data/datasource/todo_datasource.dart';
import 'package:architecture_sample/data/datasource/todo_datasource_impl.dart';
import 'package:architecture_sample/data/dio_client.dart';
import 'package:architecture_sample/data/repository/todo_repository.dart';
import 'package:get_it/get_it.dart';

import '../repository/todo_repository_impl.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<TodoDataSource>(() => TodoDataSourceImpl(dioClient: getIt()));
  getIt.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(todoDataSource: getIt()));
}