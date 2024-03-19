import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/model/post.dart';
import '../data/posts_repository.interface.dart';
import '../data/provider.dart';
part 'posts_service.g.dart';

class PostsService {
  final IPostsRepository _repo;
  const PostsService(this._repo);
  Future<List<Post>> posts({
    int? pageNumber,
    int? itemsPerPage,
    String? query,
    String? orderKey,
    bool? ascending,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (pageNumber != null) {
      queryParameters.addAll({"page": pageNumber});
    }
    if (itemsPerPage != null) {
      queryParameters.addAll({"limit": itemsPerPage});
    }
    if (query != null && query.isNotEmpty) {
      queryParameters.addAll({"search": query});
    }
    if (ascending != null) {
      queryParameters.addAll({"order": ascending ? "asc" : "desc"});
    }
    if (orderKey != null) {
      queryParameters.addAll({"orderBy": orderKey});
    }

    return await _repo.posts(queryParameters: queryParameters);
  }
}

@Riverpod(keepAlive: true)
PostsService postsService(PostsServiceRef ref) {
  final repo = ref.read(postsRepositoryProvider);
  return PostsService(repo);
}
