import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  String id;
  String time;
  String senderUid;
  String message;

  Chat(this.time,this.senderUid,this.message);

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<dynamic, dynamic> toJson() => _$ChatToJson(this);

  factory Chat.fromFirestore(DocumentSnapshot documentSnapshot) {
    Chat user = Chat.fromJson(documentSnapshot.data);
    user.id = documentSnapshot.documentID;
    return user;
  }
}
