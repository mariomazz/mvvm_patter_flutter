import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:mvvm_patter_flutter/src/common/extensions/dio.dart';
import 'package:mvvm_patter_flutter/src/core/cache_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/exceptions/http_no_data_receive.dart';
import '../../../common/exceptions/response_format_exception.dart';
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
  final CancelToken cancelToken;
  final CacheOptions cacheOptions;
  final CacheStore cacheStore;
  TodosRepository({
    required this.client,
    required this.cancelToken,
    required this.cacheOptions,
    required this.cacheStore,
  });

  @override
  Future<Todo> getTodo(int todoId,
      {Map<String, dynamic> queryParameters = const {}}) async {
    final res = await client.reqAndErrorMapping(
      "todos/$todoId",
      cancelToken: cancelToken,
      options: cacheOptions
          .copyWith(policy: CachePolicy.forceCache)
          .toOptions()
          .copyWith(method: "get"),
      queryParameters: queryParameters,
    );

    if (res.statusCode == 200 || res.statusCode == 304) {
      return Todo.fromJson(res.data);
    } else if (res.statusCode == 204) {
      throw HttpNoDataReceive();
    } else {
      throw ResponseFormatException();
    }
  }

  @override
  Future<Todos> getTodos(
      {Map<String, dynamic> queryParameters = const {}}) async {
    final res = await client.reqAndErrorMapping(
      "todos",
      cancelToken: cancelToken,
      options: cacheOptions
          .copyWith(policy: CachePolicy.noCache)
          .toOptions()
          .copyWith(method: "get"),
      queryParameters: queryParameters,
    );
    if (res.statusCode == 200 || res.statusCode == 304) {
      return todosFromList(res.data);
    } else if (res.statusCode == 204) {
      throw HttpNoDataReceive();
    } else {
      throw ResponseFormatException();
    }
  }
}

@Riverpod(keepAlive: true)
ITodosRepository todosRepository(TodosRepositoryRef ref) {
  final baseOptions = BaseOptions(
    baseUrl: Env.mockapiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
  );
  final cancelToken = CancelToken();
  final client = Dio(baseOptions);
  final cacheStore = ref.read(cacheStoreProvider);
  final cacheOptions = CacheOptions(
    keyBuilder: (options) => options.uri.toString(),
    priority: CachePriority.high,
    maxStale: Duration(days: 7),
    store: cacheStore,
    hitCacheOnErrorExcept: [],
  );
  client.interceptors.addAll(
    [
      LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint:(data)=> log(data.toString(),error: data,),
      ),
      DioCacheInterceptor(options: cacheOptions)
    ],
  );

  ref.onDispose(() {
    client.close();
    cancelToken.cancel();
  });
  return TodosRepository(
    client: client,
    cancelToken: cancelToken,
    cacheOptions: cacheOptions,
    cacheStore: cacheStore,
  );
}
