import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/utils/in_memory_store.dart';
import '../data/todos_repository.dart';
import '../model/todo_dto.dart';
part 'todos_service.g.dart';

class TodosService {
  final ITodosRepository todosRepo;
  TodosService({required this.todosRepo});

  final _todos = InMemoryStore<Todos>(null);
  final _todo = InMemoryStore<Todo>(null);

  Stream<Todos?> getTodos() {
    return _todos.stream;
  }

  Stream<Todo?> getTodo() {
    return _todo.stream;
  }

  Future<void> loadTodos(
      {Map<String, dynamic> queryParameters = const {}}) async {
    _todos.value = null;
    final a = await todosRepo.getTodos(queryParameters: queryParameters);
    _todos.value = a;
  }

  Future<void> loadTodo(int todoId,
      {Map<String, dynamic> queryParameters = const {}}) async {
    _todo.value = null;
    final a = await todosRepo.getTodo(todoId, queryParameters: queryParameters);
    _todo.value = a;
  }
}

@Riverpod()
TodosService todosService(TodosServiceRef ref) {
  final repo = ref.watch(todosRepositoryProvider);
  return TodosService(todosRepo: repo);
}

@Riverpod()
Stream<Todos> todos(TodosRef ref) {
  final repo = ref.watch(todosServiceProvider);
  return repo.getTodos().where((todos) => todos != null).cast<Todos>();
}

@Riverpod()
Stream<Todo> todo(TodoRef ref) {
  final repo = ref.watch(todosServiceProvider);
  return repo.getTodo().where((todo) => todo != null).cast<Todo>();
}
