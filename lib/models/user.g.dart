// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String,
    json['status'] as String,
    json['imageUrl'] as String,
    json['time'] as String,
    json['messageType'] as String,
    json['message'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'time': instance.time,
      'messageType': instance.messageType,
      'message': instance.message,
    };
