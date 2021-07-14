import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo_project/chat_room.dart';
import 'package:firebase_demo_project/models/chats/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<User>>(
            create: (_) => streamOfUsers(), initialData: []),
        StreamProvider<List<Chat>>(
            create: (_) => ChatRoom().streamOfChats(), initialData: []),
      ],
      child: MyHomePage(),
    );
  }

  Stream<List<User>> streamOfUsers() {
    var ref = Firestore.instance.collection('users');
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => User.fromFirestore(doc)).toList());
  }
}

class MyHomePage extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase-Provider Demo"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop(context);
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear();
                  },
                  child: Row(
                    children: [
                      Text(
                        'Log Out ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.logout,
                        size: 26.0,
                      ),
                    ],
                  ),
                )),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    User user = users[index];

                    return UserChatList(
                        name: user.name,
                        status: user.status,
                        isMessageRead: true,
                        imageUrl: user.imageUrl,
                        time: user.time,
                        id: user.id);
                    // Padding(
                    //   padding: EdgeInsets.all(10),
                    //   child: ListTile(
                    //     title: Text(user.name,textAlign: TextAlign.end,),
                    //     trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => _removeUser(user)),
                    //     //leading: IconButton(icon: Icon(Icons.edit), onPressed: () => _updateUser(user)),
                    //   ),
                    // );
                  }),
            ),
          ],
        ));
  }
}

class UserChatList extends StatefulWidget {
  String id;
  String name;
  String status;
  String imageUrl;
  String time;
  bool isMessageRead;
  UserChatList(
      {@required this.name,
      @required this.status,
      @required this.imageUrl,
      @required this.time,
      @required this.isMessageRead,
      this.id});
  @override
  _UserChatListState createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatRoom(
        //     name: widget.name, imageUrl: widget.imageUrl, id: widget.id),));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(
                name: widget.name, imageUrl: widget.imageUrl, id: widget.id),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl ?? ''),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.status ?? '',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time ?? '',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
