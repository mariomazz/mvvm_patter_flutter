import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mvvm_patter_flutter/src/features/todos/application/todos_service.dart';
import '../../../common/utils/search_limiter.dart';
import '../model/todo_dto.dart';
part 'todos_screen_controller.g.dart';

@Riverpod()
class TodosScreenController extends _$TodosScreenController {
  late final _serviceNotifier = ref.watch(todosServiceProvider.notifier);

  final _querySearchKey = "q";
  final _querySortKey = "_sort";
  final _queryOrderKey = "_order";
  // pagination
  final _queryPageKey = "_page";
  final _queryItemsPerPageKey = "_limit";
  final _todosTitleOrderKey = "title";
  String _todosSearchString = "";
  final int _todosPaginationItemsPerPage = 10;

  void Function(Todos todos, int? nextKey) onPaginationTodos = (_, __) {};
  void Function() onPaginationRefresh = () {};
  void Function(Object) onError = (err) {};

  late final _todosSerchLimiter = SearchLimiter<void>(
    fetch: (text) async {
      _todosSearchString = text;
      return onPaginationRefresh();
    },
  );

  @override
  TodosScreenControllerState build() {
    _initialize();
    return TodosScreenControllerState.loading(todosOrderAscending: false);
  }

  void onSearchTodos(String search) {
    _todosSerchLimiter.search(search);
  }

  void onOrderIconTap() async {
    state = state.copyWith(todosOrderAscending: !state.todosOrderAscending);
    onPaginationRefresh();
  }

  void onPaginationStart(int pageKey) async {
    final query = {
      _queryItemsPerPageKey: _todosPaginationItemsPerPage,
      _queryPageKey: pageKey,
      _queryOrderKey: _todosTitleOrderKey,
      _querySortKey: state.todosOrderAscending ? "asc" : "desc",
    };

    if (_todosSearchString.isNotEmpty) {
      query.addAll({_querySearchKey: _todosSearchString});
    }

    final newItems = await _loadTodos(queryParameters: query);
    final isLastPage = newItems.length < _todosPaginationItemsPerPage;
    if (isLastPage) {
      onPaginationTodos(newItems, null);
    } else {
      final nextPageKey = pageKey + 1;
      onPaginationTodos(newItems, nextPageKey);
    }
  }

  Future<void> onActivatePullToRefresh() async {
    return await Future.sync(() => onPaginationRefresh());
  }

  Future<Todos> _loadTodos(
      {Map<String, dynamic> queryParameters = const {}}) async {
    await _serviceNotifier.loadTodos(queryParameters: queryParameters);
    return state.todos.value ?? [];
  }

  void _initialize() async {
    ref.listen(todosServiceProvider, (o, n) {
      state = state.copyWith(todos: n.todos);
      if (n.todos.error != null) {
        onError(n.todos.error!);
      }
    }, onError: (err, s) {
      onError(err);
    });
  }
}

class TodosScreenControllerState {
  final AsyncValue<Todos> todos;
  final bool todosOrderAscending;
  TodosScreenControllerState({
    required this.todos,
    required this.todosOrderAscending,
  });

  factory TodosScreenControllerState.loading(
      {required bool todosOrderAscending}) {
    return TodosScreenControllerState(
      todos: const AsyncValue.loading(),
      todosOrderAscending: todosOrderAscending,
    );
  }

  TodosScreenControllerState copyWith({
    AsyncValue<Todos>? todos,
    bool? todosOrderAscending,
  }) {
    return TodosScreenControllerState(
      todos: todos ?? this.todos,
      todosOrderAscending: todosOrderAscending ?? this.todosOrderAscending,
    );
  }
}
