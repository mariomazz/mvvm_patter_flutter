import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/widgets/constants.dart';
import '../model/todo_dto.dart';
part 'todos_repository.g.dart';

abstract class ITodosRepository {
  Future<List<Todo>> getTodos(
      {Map<String, dynamic> queryParameters = const {}});
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
      {Map<String, dynamic> queryParameters = const {}}) {
    return client
        .get("todos/$todoId", queryParameters: queryParameters)
        .then(((res) => Todo.fromJson(res.data)));
  }

  @override
  Future<List<Todo>> getTodos(
      {Map<String, dynamic> queryParameters = const {}}) {
    return client.get("todos", queryParameters: queryParameters).then(
        ((res) => List.from(res.data).map((e) => Todo.fromJson(e)).toList()));
  }
}

@Riverpod(keepAlive: false)
ITodosRepository todosRepository(TodosRepositoryRef ref) {
  final baseOptions = BaseOptions(
    baseUrl: jsonPlaceholderApiBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
  );
  final client = Dio(baseOptions);
  return TodosRepository(client: client);
}
