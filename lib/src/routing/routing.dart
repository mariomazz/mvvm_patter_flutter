import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/todos/presentation/todo_screen.dart';
import '../features/todos/presentation/todos_screen.dart';
import 'routes.dart';
part 'routing.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: todosRoute,
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
    ],
  );
}
