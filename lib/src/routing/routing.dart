import 'package:asf_flutter_common/asf_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_patter_flutter/src/features/authentication/application/auth_service.dart';
import 'package:mvvm_patter_flutter/src/features/posts/presentation/posts_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/authentication/presentation/no_auth_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/todos/presentation/todo_screen.dart';
import '../features/todos/presentation/todos_screen.dart';
import 'routes.dart';
part 'routing.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authService = ref.read(authServiceProvider);
  return GoRouter(
    refreshListenable: GoRouterRefreshStream(streams: [authService.onChangeIsAuth()]),
    initialLocation: postsRoute,
    routes: [
      GoRoute(
        path: todosRoute,
        pageBuilder: (ctx, state) {
          return const MaterialPage(child: TodosScreen());
        },
        routes: [
          GoRoute(
            path: ":todoId",
            redirect: (ctx, state) {
              final todoId = int.tryParse(state.pathParameters["todoId"] ?? '');
              if (todoId == null) {
                return todosRoute;
              } else {
                return null;
              }
            },
            pageBuilder: (ctx, state) {
              final todoId = int.parse(state.pathParameters["todoId"]!);
              return MaterialPage(child: TodoScreen(todoId: todoId));
            },
          ),
        ],
      ),
      GoRoute(
        path: postsRoute,
        pageBuilder: (ctx, state) {
          return const MaterialPage(child: PostsScreen());
        },
      ),
      GoRoute(
        path: profileRoute,
        pageBuilder: (ctx, state) {
          return const MaterialPage(child: ProfileScreen());
        },
      ),
      GoRoute(
        path: authRoute,
        pageBuilder: (ctx, state) {
          return const MaterialPage(child: NoAuthScreen());
        },
      ),
    ],
    redirect: (ctx, state) async {
      final isAuth = authService.isAuth;

      if (!isAuth && state.matchedLocation != authRoute) {
        return authRoute;
      } else if (isAuth && state.matchedLocation == authRoute) {
        return todosRoute;
      }

      return null;
    },
  );
}
