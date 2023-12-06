import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_screen_controller.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({required this.todoId, super.key});
  final int todoId;

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  late final todoController = (todoScreenControllerProvider(widget.todoId));
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoControllerNotifier = ref.read(todoController.notifier);

    final controllerValue = ref.watch(todoController);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("todo ${widget.todoId}"),
        actions: [
          IconButton(
            onPressed: todoControllerNotifier.onTapRefreshTodoButton,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: controllerValue.todo.when(
        data: (todo) {
          return Center(
            child: ListTile(
              leading: Text("Id ${todo.id}"),
              title: Text("Titolo : ${todo.title}"),
              trailing: Text("Id Utente : ${todo.userId}"),
              subtitle: Text("Completato : ${todo.completed}"),
            ),
          );
        },
        error: (err, stacktrace) {
          return Center(child: Text(err.toString()));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
