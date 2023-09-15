import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../env/env.dart';
import 'model/todo.dart';
part 'todos_repository.g.dart';

abstract class ITodosRepository {
  Future<Todos> getTodos({Map<String, dynamic> queryParameters = const {}});
  Future<Todo> getTodo(int todoId,
      {Map<String, dynamic> queryParameters = const {}});
}

class TodosRepository implements ITodosRepository {
  final Dio client;
  TodosRepository({
    required this.client,
  });

  @override
  Future<Todo> getTodo(int todoId,
      {Map<String, dynamic> queryParameters = const {}}) async {
    return client
        .get("todos/$todoId", queryParameters: queryParameters)
        .then((res) => Todo.fromJson(res.data));
  }

  @override
  Future<Todos> getTodos(
      {Map<String, dynamic> queryParameters = const {}}) async {
    return client
        .get("todos", queryParameters: queryParameters)
        .then((res) => todosFromList(res.data));
  }
}

@Riverpod(keepAlive: true)
ITodosRepository todosRepository(TodosRepositoryRef ref) {
  final baseOptions = BaseOptions(
    baseUrl: Env.mockapiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
  );
  final client = Dio(baseOptions);
  return TodosRepository(client: client);
}
