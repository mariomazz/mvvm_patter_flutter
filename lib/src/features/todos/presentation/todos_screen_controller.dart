import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mvvm_patter_flutter/src/features/todos/application/todos_service.dart';
import '../../../common/utils/search_limiter.dart';
import '../data/model/todo.dart';
part 'todos_screen_controller.g.dart';

@Riverpod()
class TodosScreenController extends _$TodosScreenController {
  late final _serviceNotifier = ref.read(todosServiceProvider.notifier);
  final _subscriptions = <ProviderSubscription>[];
  String? _searchValue;
  final int _todosPaginationItemsPerPage = 10;
  final _todosTitleOrderKey = "title";

  void Function(Todos todos, int? nextKey) onPaginationTodos = (_, __) {};
  void Function() onPaginationRefresh = () {};
  void Function(Object) onError = (err) {};

  late final _todosSerchLimiter = SearchLimiter<void>(
    fetch: (text) async {
      _searchValue = text;
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
    onPaginationRefresh();
  }

  void onPaginationStart(int pageKey) async {
    final asyncItems = await _serviceNotifier
        .loadTodos(
          //pagination
          paginationPage: pageKey,
          paginationItemsPerPage: _todosPaginationItemsPerPage,
          // search
          fullTextSearch: _searchValue,
          // ordering
          orderKey: _todosTitleOrderKey,
          orderAscending: state.todosOrderAscending,
        )
        .then((_) => state.todos);

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
