import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String name;
  String status;
  String imageUrl;
  String time;
  String messageType;
  String message;

  User(this.name,this.status,this.imageUrl,this.time,this.messageType,this.message);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<dynamic, dynamic> toJson() => _$UserToJson(this);

  factory User.fromFirestore(DocumentSnapshot documentSnapshot) {
    User user = User.fromJson(documentSnapshot.data);
    user.id = documentSnapshot.documentID;
    return user;
  }
}
