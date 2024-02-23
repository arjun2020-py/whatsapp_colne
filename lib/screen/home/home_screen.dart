import 'package:flutter/material.dart';
import 'package:whatsapp_clone/firebase_auth_services/auth_services.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_widget.dart';

import '../../utils/custom_color/custom_color_widget.dart';
import '../Calls/call_screen.dart';
import '../Chat/chat_screen.dart';
import '../Status/status_screen.dart';
import '../community/pages/community_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, });
  final 
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    //DefaultTabController ->
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: appbarMainColor,
          title: CustomTextWidget(
              text: 'WhatsApp',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w500),
          actions: [
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            PopupMenuButton(
              color: whiteColor,
              iconColor: Colors.white,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(child: Text("new group")),
                  PopupMenuItem(child: Text("new brodcast")),
                  PopupMenuItem(child: Text("Linked deveices")),
                  PopupMenuItem(child: Text("Started messgae")),
                  PopupMenuItem(child: Text("Pyament")),
                  PopupMenuItem(child: Text("Setting")),
                  PopupMenuItem(
                      child: InkWell(
                          onTap: () => firebaseAuthServices.siginout(context),
                          child: Text('siginOut')))
                ];
              },
            )
          ],
          bottom: TabBar(
            tabs: [
              Icon(
                Icons.groups,
                color: whiteColor,
              ),
              Text(
                "Chats",
                style: TextStyle(color: whiteColor),
              ),
              Text(
                "Updates",
                style: TextStyle(color: whiteColor),
              ),
              Text(
                "Calls",
                style: TextStyle(color: whiteColor),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CommunityScreen(),
            ChatScreen(),
            StatusScreen(),
            CallScreen(),
          ],
        ),
      ),
    );
  }
}
