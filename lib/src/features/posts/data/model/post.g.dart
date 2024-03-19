// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      userId: json['userId'] as String,
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      placeholderImageUrl: json['placeholderImageUrl'] as String,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'creationDate': instance.creationDate.toIso8601String(),
      'placeholderImageUrl': instance.placeholderImageUrl,
    };
