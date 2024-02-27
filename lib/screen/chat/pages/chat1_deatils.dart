import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

import '../../../utils/custom_color/custom_color_widget.dart';
import '../compoents/message_bubble.dart';
import '../cubit/chat_cubit.dart';

class Chat1Deatils extends StatelessWidget {
  Chat1Deatils({super.key, required this.id, required this.groupName});

  // var userId;

  final String id;
  String groupName;

  late Future<DocumentSnapshot> futureData;

  //create instance  of user
  final _messageConntroller = TextEditingController();
  var messageRef = FirebaseFirestore.instance
      .collection('message_collection')
      .orderBy('add_time', descending: true);
  bool showSent = false;

  bool showEmoji = false; //emjio in whatsapp

  FocusNode focusNode = FocusNode();

  var datetime = DateTime.now();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(context),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var cubit = context.read<ChatCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: appbarMainColor,
              leadingWidth: 110, //provide
              leading: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    color: whiteColor,
                  ), //pop is used go back to home page
                  CircleAvatar(
                    radius: 30,
                    //  backgroundImage: NetworkImage("d001")
                  ),
                ],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupName,
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    "online",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              actions: [
                const Icon(Icons.video_call),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.call),
                PopupMenuButton(itemBuilder: (context) {
                  return [
                    PopupMenuItem(child: Text("Serach")),
                    PopupMenuItem(child: Text("Mute notfications")),
                    PopupMenuItem(child: Text("Disappering messgaes")),
                    PopupMenuItem(child: Text("Wallpaper")),
                    PopupMenuItem(child: Text("More")),
                    // PopupMenuItem(child: child)
                  ];
                }),
              ],
            ),
            body: Stack(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: firebaseFirestore
                        .collection('chats')
                        .doc(id)
                        .collection('messages')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        chatAppShowToast(
                            message:
                                'some error is occured====${snapshot.hasError}');
                      }
                      if (snapshot.hasData) {
                        List? messages = snapshot.data!.docs;
                        return Form(
                          key: formKey,
                          child: Stack(
                            children: [
                              ListView.separated(
                                itemCount: messages.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider();
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return MessageBubble(
                                      username: messages[index]['Username'],
                                      message: messages[index]['Message'],
                                      dpURL: messages[index]['Userphoto'],
                                      isMe: firebaseAuth.currentUser?.email ==
                                          messages[index]['Useremail']);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(child:CircularProgressIndicator());
                    }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20)), //it provide cricle edge in card
                              child: TextFormField(
                                controller: cubit.chatMessageController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: "mesaage",
                                  prefixIcon: IconButton(
                                      onPressed: () {
                                        showEmoji
                                            ? focusNode.unfocus()
                                            : focusNode.hasFocus;
                                      },
                                      icon: Icon(showEmoji
                                          ? Icons.keyboard
                                          : Icons.emoji_emotions_outlined)),
                                ),
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            backgroundColor: appbarMainColor,
                            onPressed: () async {
                              // cubit.messageCollection();

                              await cubit.addMessage(
                                  id,
                                  cubit.chatMessageController.text,
                                  DateFormat('hh mm a').format(DateTime.now()),
                                  groupName);
                            },
                            child: Icon(
                              //(showSent == true) ?
                              Icons.send,
                              color: whiteColor,
                              //: Icons.mic
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
