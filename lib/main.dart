import 'package:architecture_sample/data/di/data_module.dart';
import 'package:architecture_sample/data/repository/todo_repository.dart';
import 'package:architecture_sample/ui/screen/add_todo_screen.dart';
import 'package:architecture_sample/ui/screen/add_todo_viewmodel.dart';
import 'package:architecture_sample/ui/screen/todo_list_screen.dart';
import 'package:architecture_sample/ui/screen/todo_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddTodoViewModel(
            todoRepository: GetIt.I.get<TodoRepository>())
        ),
        ChangeNotifierProvider(create: (context) => TodoListViewModel(
            todoRepository: GetIt.I.get<TodoRepository>())
        )
      ],
      child: const TodoApp(),
    )
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoListScreen(),
    );
  }
}