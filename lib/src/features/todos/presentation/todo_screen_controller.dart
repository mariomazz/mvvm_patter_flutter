import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mvvm_patter_flutter/src/features/todos/application/todos_service.dart';
import '../model/todo_dto.dart';
part 'todo_screen_controller.g.dart';

@Riverpod()
class TodoScreenController extends _$TodoScreenController {
  late final _serviceNotifier = ref.read(todosServiceProvider.notifier);

  @override
  TodoScreenControllerState build(int todoId) {
    _initialize();
    reloadTodo(todoId);
    return TodoScreenControllerState.loading();
  }

  Future<void> reloadTodo(int todoId,
      {Map<String, dynamic> queryParameters = const {}}) async {
    return await _serviceNotifier.loadTodo(todoId,
        queryParameters: queryParameters);
  }

  void _initialize() async {
    ref.listen(todosServiceProvider, (o, n) {
      state = state.copyWith(todo: n.todo);
    });
  }
}

class TodoScreenControllerState {
  final AsyncValue<Todo> todo;
  TodoScreenControllerState({
    required this.todo,
  });

  factory TodoScreenControllerState.loading() {
    return TodoScreenControllerState(todo: const AsyncValue.loading());
  }

  TodoScreenControllerState copyWith({
    AsyncValue<Todo>? todo,
  }) {
    return TodoScreenControllerState(
      todo: todo ?? this.todo,
    );
  }
}
