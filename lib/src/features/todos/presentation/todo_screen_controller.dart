import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mvvm_patter_flutter/src/features/todos/application/todos_service.dart';

import '../data/model/todo.dart';
part 'todo_screen_controller.g.dart';

@Riverpod()
class TodoScreenController extends _$TodoScreenController {
  late final _service = ref.read(todosServiceProvider.notifier);
  final _subscriptions = <ProviderSubscription>[];
  @override
  TodoScreenControllerState build(int todoId) {
    _initialize();
    _disposing();
    _service.loadTodo(todoId);
    return TodoScreenControllerState.loading();
  }

  void onTapRefreshTodoButton() {
    _service.loadTodo(todoId);
  }

  void _initialize() async {
    final s1 = ref.listen(todosServiceProvider, (o, n) {
      state = state.copyWith(todo: n.todo);
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
