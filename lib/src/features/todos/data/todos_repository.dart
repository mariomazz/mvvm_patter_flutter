import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/widgets/constants.dart';
part 'todos_repository.g.dart';

abstract class ITodosRepository {
  Future<Response> getTodos({Map<String, dynamic> queryParameters = const {}});
  Future<Response> getTodo(int todoId,
      {Map<String, dynamic> queryParameters = const {}});
}

class TodosRepository implements ITodosRepository {
  final Dio client;
  TodosRepository({
    required this.client,
  });

  @override
  Future<Response> getTodo(int todoId,
      {Map<String, dynamic> queryParameters = const {}}) async {
    return client.get("todos/$todoId", queryParameters: queryParameters);
  }

  @override
  Future<Response> getTodos(
      {Map<String, dynamic> queryParameters = const {}}) async {
    return client.get("todos", queryParameters: queryParameters);
  }
}

@Riverpod(keepAlive: true)
ITodosRepository todosRepository(TodosRepositoryRef ref) {
  final baseOptions = BaseOptions(
    baseUrl: jsonPlaceholderApiBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
  );
  final client = Dio(baseOptions);
  return TodosRepository(client: client);
}
