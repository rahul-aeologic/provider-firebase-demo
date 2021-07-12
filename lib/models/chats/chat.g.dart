// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    json['time'] as String,
    json['senderUid'] as String,
    json['message'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
  'id': instance.id,
  'time': instance.time,
  'senderUid': instance.senderUid,
  'message': instance.message,
};
