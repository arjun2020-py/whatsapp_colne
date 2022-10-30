import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Chat/models/chat_model.dart';

import 'chat_tile.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key });
 
  List<User> Users = [
    User(naame: "Anu",
     message: "whatsapp man", 
     image: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
      updateAt: "18.30",
      ),
    User(
      naame: "Mummed sheen",
      message: "how are you",
      image: "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
      isGroup: false,
      updateAt: "16.0",
    ),
    
    User(
      naame: "kerala blasters fans",
      message: "what about yesaday match ",
      image: "",
      isGroup: true,
      updateAt: "08.0",
    ),
    User(
      naame: "flutter indaia",
      message: "what about the updation ",
      image: "https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
      isGroup: true,
      updateAt: "11.0",
    ),
    User(
      naame: "Ansif",
      message: "enthla amacha ",
      image: "https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
      isGroup: false,
      updateAt: "02.0",
    ),
    User(
      naame: "Rhaul",
      message: "what about the updation ",
      image: "https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
      isGroup: false,
      updateAt: "08.0",
    ),
  ]; //list of data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Users.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatTile(userData: Users[index],);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
      ),
    );
  }
}