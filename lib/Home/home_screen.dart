import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Chat/chat_screen.dart';
import 'package:whatsapp_clone/Status/status_screen.dart';
import 'package:whatsapp_clone/Calls/call_screen.dart';
import 'package:whatsapp_clone/cmera/camera_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //DefaultTabController -> 
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          
          title: const Text("Whatsapp"),
          actions: [
            const Icon(Icons.search),
            PopupMenuButton(
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(child: Text("new group")),
                  PopupMenuItem(child: Text("new brodcast")),
                  PopupMenuItem(child: Text("Linked deveices")),
                  PopupMenuItem(child: Text("Started messgae")),
                  PopupMenuItem(child: Text("Pyament")),
                  PopupMenuItem(child: Text("Setting")),
                ];
              },
            )
          ],
          bottom:const TabBar(
            tabs: [
              Icon(Icons.camera_alt),
              Text("CHATS"),
              Text("STATUS"),
              Text("CALLS"),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            CmeraScreen(),
            ChatScreen(),
            StatusScreen(),
            CallScreen(),
          ],
        ),
      ),
    );
  }
}
