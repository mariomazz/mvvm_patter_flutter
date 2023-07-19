import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_patter_flutter/src/features/todos/presentation/todos_screen_controller.dart';
import 'package:mvvm_patter_flutter/src/routing/routes.dart';
import 'package:mvvm_patter_flutter/src/routing/routing.dart';

class TodosScreen extends ConsumerStatefulWidget {
  const TodosScreen({super.key});

  @override
  ConsumerState<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends ConsumerState<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    final todosViewController =
        ref.watch(todosScreenControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("todos"),
      ),
      body: todosViewController.getAsyncTodos(ref).when(
            data: (todos) => SizedBox.expand(
              child: RefreshIndicator(
                onRefresh: () async => await todosViewController.reloadTodos(),
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final todo = todos.elementAt(index);
                    return ListTile(
                      onTap: () => ref
                          .read(goRouterProvider)
                          .go("$todosRoute/${todo.id}"),
                      leading: Text("Id ${todo.id}"),
                      title: Text("Titolo : ${todo.title}"),
                      trailing: Text("Id Utente : ${todo.userId}"),
                      subtitle: Text("Completato : ${todo.completed}"),
                    );
                  },
                ),
              ),
            ),
            error: (err, stacktrace) => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
