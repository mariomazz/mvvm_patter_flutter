import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mvvm_patter_flutter/src/features/todos/application/todos_service.dart';
import '../../../common/utils/search_limiter.dart';
import '../data/model/todo.dart';
part 'todos_screen_controller.g.dart';

@Riverpod()
class TodosScreenController extends _$TodosScreenController {
  late final _serviceNotifier = ref.watch(todosServiceProvider.notifier);
  final _subscriptions = <ProviderSubscription>[];

  final _globalQueryParameters = <String, dynamic>{};

  final _querySearchKey = "search";
  final _querySortKey = "order";
  final _queryOrderKey = "orderBy";
  // pagination
  final _queryPageKey = "page";
  final _queryItemsPerPageKey = "limit";
  final _todosTitleOrderKey = "title";
  final int _todosPaginationItemsPerPage = 10;

  void Function(Todos todos, int? nextKey) onPaginationTodos = (_, __) {};
  void Function() onPaginationRefresh = () {};
  void Function(Object) onError = (err) {};

  late final _todosSerchLimiter = SearchLimiter<void>(
    fetch: (text) async {
      if (text.isNotEmpty) {
        _globalQueryParameters.addAll({_querySearchKey: text});
      } else {
        _globalQueryParameters.remove(_querySearchKey);
      }
      return onPaginationRefresh();
    },
  );

  @override
  TodosScreenControllerState build() {
    _initialize();
    _disposing();
    return TodosScreenControllerState.loading(todosOrderAscending: false);
  }

  void onSearchTodos(String search) {
    _todosSerchLimiter.search(search);
  }

  void onOrderIconTap() async {
    state = state.copyWith(todosOrderAscending: !state.todosOrderAscending);
    _globalQueryParameters.addAll({
      _querySortKey: state.todosOrderAscending ? "asc" : "desc",
      _queryOrderKey: _todosTitleOrderKey,
    });
    onPaginationRefresh();
  }

  void onPaginationStart(int pageKey) async {
    _globalQueryParameters.addAll({
      _queryItemsPerPageKey: _todosPaginationItemsPerPage,
      _queryPageKey: pageKey,
    });

    final asyncItems =
        await _loadTodos(queryParameters: _globalQueryParameters);

    if (asyncItems.hasError) {
      return onError(asyncItems.error!);
    } else if (asyncItems.valueOrNull == null) {
      return;
    }

    final items = asyncItems.valueOrNull!;
    final isLastPage = items.length < _todosPaginationItemsPerPage;
    if (isLastPage) {
      onPaginationTodos(items, null);
    } else {
      final nextPageKey = pageKey + 1;
      onPaginationTodos(items, nextPageKey);
    }
  }

  Future<void> onActivatePullToRefresh() async {
    return await Future.sync(() => onPaginationRefresh());
  }

  Future<AsyncValue<Todos>> _loadTodos(
      {Map<String, dynamic> queryParameters = const {}}) async {
    return await _serviceNotifier
        .loadTodos(queryParameters: queryParameters)
        .then((_) => state.todos);
  }

  void _initialize() async {
    final s1 = ref.listen(todosServiceProvider, (o, n) {
      state = state.copyWith(todos: n.todos);
    });
    _subscriptions.addAll([s1]);
  }

  void _disposing() {
    ref.onDispose(() {
      for (var sub in _subscriptions) {
        sub.close();
      }
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
