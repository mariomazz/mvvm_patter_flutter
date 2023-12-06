import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cache_store.g.dart';

@Riverpod(keepAlive: true)
MemCacheStore cacheStore(CacheStoreRef ref) {
  return MemCacheStore(maxSize: 40485760, maxEntrySize: 4048576);
}
