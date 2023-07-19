import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_patter_flutter/src/features/todos/application/todos_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/todo_dto.dart';
part 'todo_screen_controller.g.dart';

@Riverpod()
class TodoScreenController extends _$TodoScreenController {
  late final _service = ref.watch(todosServiceProvider);

  AsyncValue<Todo> getAsyncTodo(WidgetRef ref) {
    return ref.watch(todoProvider);
  }

  @override
  Future<void> build(int todoId) async {
    return await _service.loadTodo(todoId);
  }

  Future<void> reloadTodo(int todoId) async {
    return await _service.loadTodo(todoId);
  }
}
