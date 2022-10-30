import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Calls/callmodels/call_model.dart';

import 'call_tile.dart';

class CallScreen extends StatelessWidget {
   CallScreen({super.key});

  List<UserCall> callList = [
    UserCall(image: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    name: "arjun",
    updateAt: "19.0pm",
    option: true,
    calltpe: true,
    ),
     UserCall(image: "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    name: "arun",
    updateAt: "19.0am",
    option: false,
    calltpe: false
    ),
     UserCall(image: "https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    name: "akhil",
    updateAt: "01.0am",
    option: true,
    calltpe: true
    ),
     UserCall(image: "https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    name: "akash",
    updateAt: "08.0pam",
    option: false,
    calltpe: false
    ),
     UserCall(image: "https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    name: "anuvith",
    updateAt: "07.0pm",
    option: true,
    calltpe: false
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: callList.length,
        itemBuilder: (BuildContext context, int index) {
         return CallTill(usercall: callList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.call),
      ),
    );
  }
}
