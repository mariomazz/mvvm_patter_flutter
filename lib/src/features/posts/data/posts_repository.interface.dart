import 'model/post.dart';

abstract class IPostsRepository {
  Future<List<Post>> posts({final Map<String, dynamic> queryParameters = const {}});
}
