import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/model/todo.dart';
import '../data/todos_repository.dart';
part 'todos_service.g.dart';

@Riverpod(keepAlive: true)
class TodosService extends _$TodosService {
  late final _repo = ref.read(todosRepositoryProvider);
  @override
  TodosServiceState build() => TodosServiceState.loading();

  Future<void> loadTodos(
      {Map<String, dynamic> queryParameters = const {}}) async {
    state = state.copyWith(
        todos: await AsyncValue.guard(() async =>
            await _repo.getTodos(queryParameters: queryParameters)));
  }

  Future<void> loadTodo(int todoId,
      {Map<String, dynamic> queryParameters = const {}}) async {
    state = state.copyWith(
        todo: await AsyncValue.guard(() async =>
            await _repo.getTodo(todoId, queryParameters: queryParameters)));
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
