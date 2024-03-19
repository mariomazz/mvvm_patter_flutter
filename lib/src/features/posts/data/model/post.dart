import 'package:freezed_annotation/freezed_annotation.dart';
part 'post.g.dart';
part 'post.freezed.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String userId,
    required String id,
    required String title,
    required String body,
    required DateTime creationDate,
    required String placeholderImageUrl,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}

/* @freezed
class Post with _$Post {
  const factory Post({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
 */