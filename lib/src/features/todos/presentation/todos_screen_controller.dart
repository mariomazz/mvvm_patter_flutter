import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_patter_flutter/src/features/todos/application/todos_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/todo_dto.dart';
part 'todos_screen_controller.g.dart';

@Riverpod()
class TodosScreenController extends _$TodosScreenController {
  late final _service = ref.watch(todosServiceProvider);

  AsyncValue<Todos> getAsyncTodos(WidgetRef ref) {
    return ref.watch(todosProvider);
  }

  @override
  Future<void> build() async {
    return await _service.loadTodos();
  }

  Future<void> reloadTodos() async {
    return await _service.loadTodos();
  }
}
