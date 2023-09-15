// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

typedef Todos = List<Todo>;

List<Todo> todosFromList(List data) =>
    List<Todo>.from(data.map((x) => Todo.fromJson(x)));

List<Todo> todosFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todosToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  final int userId;
  final bool completed;
  final String title;
  final String id;

  Todo({
    required this.userId,
    required this.completed,
    required this.title,
    required this.id,
  });

  Todo copyWith({
    int? userId,
    bool? completed,
    String? title,
    String? id,
  }) =>
      Todo(
        userId: userId ?? this.userId,
        completed: completed ?? this.completed,
        title: title ?? this.title,
        id: id ?? this.id,
      );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        userId: json["userId"],
        completed: json["completed"],
        title: json["title"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "completed": completed,
        "title": title,
        "id": id,
      };
}
