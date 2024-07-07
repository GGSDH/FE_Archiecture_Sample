import 'package:architecture_sample/ui/screen/todo_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_todo_screen.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 목록'),
      ),
      body: const TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddTodoScreen()
          ).then((_) {
            Provider.of<TodoListViewModel>(context, listen: false).getTodos();
          });
        },
        child: const Icon(Icons.add),
      )
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TodoListViewModel viewModel = Provider.of<TodoListViewModel>(context, listen: false);
      viewModel.getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListViewModel>(
      builder: (context, viewModel, child) {
        final items = viewModel.items;
        final itemCount = items.length;

        if (viewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (itemCount == 0) {
          return const Center(
            child: Text('할 일이 없습니다.'),
          );
        }

        return ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) => Dismissible(
            key: ValueKey(items[index].id),
            background: Container(
              color: Theme.of(context).colorScheme.onErrorContainer.withOpacity(0.75),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white, size: 40)
            ),
            onDismissed: (direction) {
              viewModel.deleteTodo(id: items[index].id);
            },
            child: TodoItem(content: items[index].content)
          )
        );
      }
    );
  }
}

class TodoItem extends StatelessWidget {
  final String content;

  const TodoItem({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16
          ),
          child: Text(
            content,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}