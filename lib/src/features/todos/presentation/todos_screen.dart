import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvvm_patter_flutter/src/features/todos/presentation/todos_screen_controller.dart';
import 'package:mvvm_patter_flutter/src/routing/routes.dart';
import 'package:mvvm_patter_flutter/src/routing/routing.dart';
import '../model/todo_dto.dart';

class TodosScreen extends ConsumerStatefulWidget {
  const TodosScreen({super.key});

  @override
  ConsumerState<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends ConsumerState<TodosScreen> {
  final _searchTodosTextFieldController = TextEditingController();
  final _todosPagingController = PagingController<int, Todo>(firstPageKey: 1);
  late final _todosControllerNotifier =
      ref.read(todosScreenControllerProvider.notifier);
  @override
  void initState() {
    _todosControllerNotifier.onError = (err) {
      _todosPagingController.error=err.toString();
    };
    _todosControllerNotifier.onPaginationRefresh = () {
      _todosPagingController.refresh();
    };
    _todosControllerNotifier.onPaginationTodos = (todos, nextKey) {
      _todosPagingController.appendPage(todos, nextKey);
    };
    _todosPagingController.addPageRequestListener((pageKey) {
      _todosControllerNotifier.onPaginationStart(pageKey);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchTodosTextFieldController.dispose();
    _todosPagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosController = ref.watch(todosScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("todos"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (search) {
                    _todosControllerNotifier.onSearchTodos(search);
                  },
                  controller: _searchTodosTextFieldController,
                  decoration: const InputDecoration(hintText: "Ricerca TODO"),
                ),
              ),
              IconButton(
                onPressed: () {
                  _todosControllerNotifier.onOrderIconTap();
                },
                icon: Icon(todosController.todosOrderAscending
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded),
              ),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  _todosControllerNotifier.onActivatePullToRefresh(),
              child: PagedListView<int, Todo>.separated(
                pagingController: _todosPagingController,
                builderDelegate: PagedChildBuilderDelegate<Todo>(
                  itemBuilder: (context, todo, index) => ListTile(
                    onTap: () =>
                        ref.read(goRouterProvider).go("$todosRoute/${todo.id}"),
                    leading: Text("Id ${todo.id}"),
                    title: Text("Titolo : ${todo.title}"),
                    trailing: Text("Id Utente : ${todo.userId}"),
                    subtitle: Text("Completato : ${todo.completed}"),
                  ),
                ),
                separatorBuilder: (ctx, i) => const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
