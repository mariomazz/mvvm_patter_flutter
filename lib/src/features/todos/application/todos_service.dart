import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/model/todo.dart';
import '../data/todos_repository.dart';
part 'todos_service.g.dart';

@Riverpod(keepAlive: true)
class TodosService extends _$TodosService {
  late final _repo = ref.read(todosRepositoryProvider);
  @override
  TodosServiceState build() => TodosServiceState.loading();

  Future<void> loadTodos({
    int? paginationPage,
    int? paginationItemsPerPage,
    String? fullTextSearch,
    bool? orderAscending,
    String? orderKey,
  }) async {
    final query = <String, dynamic>{};
    if (paginationPage != null) {
      query.addAll({"page": paginationPage});
    }
    if (paginationItemsPerPage != null) {
      query.addAll({"limit": paginationItemsPerPage});
    }
    if (fullTextSearch != null && fullTextSearch.isNotEmpty) {
      query.addAll({"search": fullTextSearch});
    }
    if (orderAscending != null) {
      query.addAll({"order": orderAscending ? "asc" : "desc"});
    }
    if (orderKey != null) {
      query.addAll({"orderBy": orderKey});
    }
    state = state.copyWith(
        todos: await AsyncValue.guard(
            () async => await _repo.getTodos(queryParameters: query)));
  }

  Future<void> loadTodo(int todoId) async {
    state = state.copyWith(
        todo: await AsyncValue.guard(() async => await _repo.getTodo(todoId)));
  }
}

class TodosServiceState {
  final AsyncValue<Todo> todo;
  final AsyncValue<Todos> todos;
  TodosServiceState({
    required this.todo,
    required this.todos,
  });

  factory TodosServiceState.loading() {
    return TodosServiceState(
      todo: const AsyncValue.loading(),
      todos: const AsyncValue.loading(),
    );
  }

  TodosServiceState copyWith({
    AsyncValue<Todo>? todo,
    AsyncValue<Todos>? todos,
  }) {
    return TodosServiceState(
      todo: todo ?? this.todo,
      todos: todos ?? this.todos,
    );
  }
}
