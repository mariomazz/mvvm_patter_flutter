import 'package:dio/dio.dart';
import 'model/post.dart';
import 'posts_repository.interface.dart';

class PostsRepository implements IPostsRepository {
  final Dio _client;
  final CancelToken _cancelToken;
  const PostsRepository(this._client, this._cancelToken);
  @override
  Future<List<Post>> posts({final Map<String, dynamic> queryParameters = const {}}) async {
    return await _client
        .get("posts", cancelToken: _cancelToken, queryParameters: queryParameters)
        .then((res) => List.from(res.data).map((e) => Post.fromJson(e)).toList());
  }
}
