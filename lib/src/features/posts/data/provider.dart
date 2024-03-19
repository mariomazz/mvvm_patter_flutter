import 'package:asf_flutter_common/asf_flutter_common.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../env/env.dart';
import 'posts_repository.dart';
import 'posts_repository.interface.dart';
part 'provider.g.dart';

@Riverpod(keepAlive: true)
IPostsRepository postsRepository(PostsRepositoryRef ref) {
  final client = Dio(BaseOptions(baseUrl: Env.mockapiUrl));

  return PostsRepository(client, ref.cancelToken());
}
