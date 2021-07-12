import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo_project/models/chats/chat.dart';
import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier {
  bool _isLoading = false;


  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++
  Chat _chat;

  Chat get chat => _chat;

  set chat(Chat value) {
    _chat = value;
    notifyListeners();
  }


  Future<Chat> getChat({String categoryFilter}) async {
    isLoading = true;
    try {

        // var ref = Firestore.instance.collection('chats').document(name).collection('messages').orderBy('created',descending: false);
        // return ref.snapshots().map((list) => list.documents.map((doc) => Chat.fromFirestore(doc)).toList());


    } catch (e) {

    }
    isLoading = false;
  }

}
