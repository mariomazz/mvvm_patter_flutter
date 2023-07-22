import 'package:mvvm_patter_flutter/src/features/todos/application/todos_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/todo_dto.dart';
part 'todos_screen_controller.g.dart';

@Riverpod()
class TodosScreenController extends _$TodosScreenController {
  late final _serviceNotifier = ref.watch(todosServiceProvider.notifier);

  @override
  TodosScreenControllerState build() {
    _initialize();
    reloadTodos();
    return TodosScreenControllerState.loading();
  }

  Future<void> reloadTodos(
      {Map<String, dynamic> queryParameters = const {}}) async {
    return await _serviceNotifier.loadTodos(queryParameters: queryParameters);
  }

  void _initialize() async {
    ref.listen(todosServiceProvider, (o, n) {
      state = state.copyWith(todos: n.todos);
    });
  }
}

class TodosScreenControllerState {
  final AsyncValue<Todos> todos;
  TodosScreenControllerState({
    required this.todos,
  });

  factory TodosScreenControllerState.loading() {
    return TodosScreenControllerState(todos: const AsyncValue.loading());
  }

  TodosScreenControllerState copyWith({
    AsyncValue<Todos>? todos,
  }) {
    return TodosScreenControllerState(
      todos: todos ?? this.todos,
    );
  }
}
