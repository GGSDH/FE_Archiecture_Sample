import 'package:architecture_sample/ui/screen/add_todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTodoViewModel>(
      builder: (context, viewModel, child) {
        return const AddTodoForm();
      }
    );
  }
}

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key});

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddTodoViewModel viewModel = Provider.of<AddTodoViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(
              labelText: '할 일',
            ),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () async {
              await viewModel.addTodo(
                content: _contentController.text,
              );
              Navigator.of(context).pop();
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }
}