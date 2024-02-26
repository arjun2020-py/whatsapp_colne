import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

import '../../../utils/custom_color/custom_color_widget.dart';
import '../cubit/chat_cubit.dart';

class ChatDeatils extends StatelessWidget {
  ChatDeatils({super.key, required this.id,}) {
    _documentReference =
        FirebaseFirestore.instance.collection('chat_tile_collection').doc(id);
    futureData = _documentReference.get();
    stream = messageRef.snapshots();
  }

  // var userId;
  late Stream<QuerySnapshot> stream;
  final String id;
  late DocumentReference _documentReference;

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(context),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var cubit = context.read<ChatCubit>();
          return FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                DocumentSnapshot<Object?>? documentSnapshot = snapshot.data;
                Map data = documentSnapshot?.data() as Map;

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
                            backgroundImage: NetworkImage(data['user_url'])),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(data['name']), const Text("online")],
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
                  body: Container(
                    child: Stack(
                      children: [
                        Image.asset("assets/images/w.jpeg",
                            // height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover),
                        StreamBuilder<QuerySnapshot>(
                            stream: stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                chatAppShowToast(
                                    message:
                                        'some error is occured ${snapshot.hasError}');
                              }
                              if (snapshot.hasData) {
                                QuerySnapshot<Object?>? querySnapshot =
                                    snapshot.data;
                                List<QueryDocumentSnapshot> documents =
                                    querySnapshot!.docs;
                                List<Map> items = documents
                                    .map((e) => {
                                          "add_time": e['add_time'],
                                          "content": e['content'],
                                          "type": e['type'],
                                          "user_id": e["user_id"]
                                        })
                                    .toList();
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: items.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    //chat buble code .
                                    var data = items[index];
                                    return 
                                    Align(
                                        alignment:
                                            //  data['user_id'] ==
                                            //         FirebaseAuth
                                            //             .instance.currentUser!.uid
                                            // ?
                                            Alignment.centerRight,
                                        // : Alignment
                                        //     .centerLeft, // align chat in whatsapp using single line function
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150), //important
                                          child: Card(
                                            color: Color(0xffdcf8c6),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 7,
                                                          right: 58,
                                                          bottom: 10),
                                                  child: Text(data['content']),
                                                ),
                                                Positioned(
                                                  bottom: 3,
                                                  right: 2,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'sendAt',
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      // if (bable.isSend!)
                                                      //   Icon(
                                                      //     Icons.done_all,
                                                      //     color: bable.isReaded! ? Colors.blue : Colors.grey,
                                                      //     size: 14,
                                                      //   )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                    //Text('data');

                                    //ChatBabble(bable: chatb[index]);
                                  },
                                );
                              }

                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                        //text filed and button
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20)), //it provide cricle edge in card
                                      child: TextFormField(
                                        controller: cubit.messageController,
                                        focusNode: focusNode,
                                        onTap: () {},
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
                                                  : Icons
                                                      .emoji_emotions_outlined)),
                                          // suffixIcon: Row(
                                          //   mainAxisSize: MainAxisSize.min,
                                          //   children: [

                                          //     IconButton(
                                          //         onPressed: () {},
                                          //         icon: const Icon(Icons.currency_rupee)),
                                          //     const Icon(Icons.camera_alt),
                                          //     //  IconButton(onPressed: onPressed, icon: icon) ,
                                          //     const SizedBox(
                                          //       width: 5,
                                          //     )
                                          //   ],
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      // cubit.messageCollection();

                                      // print('------------print------------');
                                    },
                                    child: Icon(
                                        //(showSent == true) ?
                                        Icons.send
                                        //: Icons.mic
                                        ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ), //chnage the postion wedgit in flutter
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
