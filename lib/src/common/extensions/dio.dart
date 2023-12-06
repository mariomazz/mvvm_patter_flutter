import 'package:dio/dio.dart';
import '../utils/dio_request_error_mapper.dart';

extension DioExt on Dio {
  Future<Response<T>> reqAndErrorMapping<T>(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dioRequestErrorMapper(() async {
      return await request(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    });
  }
}
