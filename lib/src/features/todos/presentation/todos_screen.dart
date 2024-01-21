import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvvm_patter_flutter/src/features/todos/presentation/todos_screen_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../authentication/application/auth_service.dart';
import '../data/model/todo.dart';

class TodosScreen extends ConsumerStatefulWidget {
  const TodosScreen({super.key});

  @override
  ConsumerState<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends ConsumerState<TodosScreen> {
  final _searchTodosTextFieldController = TextEditingController();
  final _todosPagingController = PagingController<int, Todo>(firstPageKey: 1, invisibleItemsThreshold: 10);
  final _pullToRefreshController = RefreshController();
  late final _todosControllerNotifier = ref.read(todosScreenControllerProvider.notifier);
  @override
  void initState() {
    _todosControllerNotifier.onError = (err) {
      _todosPagingController.error = err;
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
    _pullToRefreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosController = ref.watch(todosScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("todos"),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authServiceProvider).logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
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
          SizedBox(height: 10, width: double.infinity),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              header: WaterDropMaterialHeader(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onRefresh: () async {
                await _todosControllerNotifier.onActivatePullToRefresh();
                _pullToRefreshController.refreshCompleted();
              },
              controller: _pullToRefreshController,
              child: PagedListView<int, Todo>.separated(
                shrinkWrap: true,
                pagingController: _todosPagingController,
                builderDelegate: PagedChildBuilderDelegate<Todo>(
                  animateTransitions: true,
                  transitionDuration: Duration(milliseconds: 250),
                  itemBuilder: (context, todo, index) => ListTile(
                    onTap: () => _todosControllerNotifier.goToTodoDetail(todo.id),
                    leading: Text("Id ${todo.id}"),
                    title: Text("Titolo : ${todo.title}"),
                    trailing: Text("Id Utente : ${todo.userId}"),
                    subtitle: Text("Completato : ${todo.completed}"),
                  ),
                ),
                separatorBuilder: (ctx, i) => Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
