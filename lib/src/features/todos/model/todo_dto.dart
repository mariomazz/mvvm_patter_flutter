import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_dto.freezed.dart';
part 'todo_dto.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

typedef Todos = List<Todo>;
