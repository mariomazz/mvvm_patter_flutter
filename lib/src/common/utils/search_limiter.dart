import 'stream_limiter.dart';

class SearchLimiter<T> extends StreamLimiter<T, String> {
  SearchLimiter({
    required super.fetch,
    super.debounce,
  });
}
