import 'package:dio/dio.dart';
import '../exceptions/connection_error_exception.dart';
import '../exceptions/http_failure_400.dart';
import '../exceptions/http_failure_500.dart';
import '../exceptions/timeout_exception.dart';

Future<T> dioRequestErrorMapper<T>(Future<T> Function() dioRequest) async {
  try {
    // throw ConnectionErrorException();
    final response = await dioRequest.call();
    return response;
  } on DioException catch (e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        throw ConnectionErrorException();
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 400) {
          throw HttpFailure400(
              message: "400 bad response", data: e.response?.data);
        } else if (e.response?.statusCode == 500) {
          throw HttpFailure500();
        } else {
          rethrow;
        }
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutException();
      case DioExceptionType.receiveTimeout:
        throw ResponseTimeoutException();
      case DioExceptionType.sendTimeout:
        throw RequestTimeoutException();
      default:
        rethrow;
    }
  } catch (e) {
    rethrow;
  }
}
