import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../application/posts_service.dart';
import '../data/model/post.dart';
part 'posts_screen_controller.g.dart';

@Riverpod(keepAlive: false)
class PostsScreenController extends _$PostsScreenController {
  final _initialState = const PostsScreenControllerState.empty();
  // late final _service = ref.read(postsServiceProvider);

  @override
  PostsScreenControllerState get state => stateOrNull ?? _initialState;

  @override
  PostsScreenControllerState build() {
    _initialize();
    _disposing();
    return _initialState;
  }

  Future<void> _initialize() async {
    state = state.copyWith(posts: await AsyncValue.guard(() async => const []));
  }

  void _disposing() {
    ref.onDispose(() {});
  }

  int get paginationItemsPerPage => 10;
}

class PostsScreenControllerState {
  final AsyncValue<List<Post>> posts;

  const PostsScreenControllerState({required this.posts});
  const PostsScreenControllerState.empty({this.posts = const AsyncLoading()});

  PostsScreenControllerState copyWith({
    AsyncValue<List<Post>>? posts,
  }) {
    return PostsScreenControllerState(
      posts: posts ?? this.posts,
    );
  }
}

@Riverpod(keepAlive: false)
Future<List<Post>> posts(PostsRef ref, {int? pageNumber, int? itemsPerPage}) async {
  final service = ref.read(postsServiceProvider);
  return await service.posts(pageNumber: pageNumber, itemsPerPage: itemsPerPage);
}
