import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'post_list_tile.dart';
import 'posts_screen_controller.dart';
import 'shimmer_post_list_tile.dart';

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(postsScreenControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            final page = index ~/ viewModel.paginationItemsPerPage + 1;
            final indexInPage = index % viewModel.paginationItemsPerPage;

            final postsList = ref.watch(
              postsProvider(itemsPerPage: viewModel.paginationItemsPerPage, pageNumber: page),
            );
            return postsList.when(
              error: (err, stack) => Text('Error $err'),
              loading: () => const ShimmerPostListTile(),
              data: (posts) {
                if (indexInPage >= posts.length) {
                  return const ShimmerPostListTile();
                }
                final post = posts[indexInPage];
                return PostListTile(
                  post: post,
                  onTap: () {},
                );
              },
            );
          },
          childCount: 100,
        ),
      ),
    );
  }
}
