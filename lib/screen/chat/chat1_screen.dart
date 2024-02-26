import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/screen/chat/pages/chat1_deatils.dart';
import 'package:whatsapp_clone/screen/chat/select_contact.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

import 'cubit/chat_cubit.dart';
import 'demo_screen.dart';
import 'models/chat_model.dart';
import 'pages/chat_details.dart';

class Chat1Screen extends StatelessWidget {
  Chat1Screen({super.key, this.email});

  String? email;
  // var reference = FirebaseFirestore.instance
  //     .collection('chat_collection')
  //     .orderBy('time', descending: true);

  // late User userDetails;

  //create instance of List<DocumentSnapShot>
  List<DocumentSnapshot>? chats;

  //create the instance of firebaseFirestore
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(context),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var cubit = context.read<ChatCubit>();
          return Scaffold(
            body: StreamBuilder<QuerySnapshot>(
                stream: firebaseFirestore
                    .collection('chats')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    chatAppShowToast(
                        message: 'some error is occured ${snapshot.error}');
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    QuerySnapshot<Object?>? querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot!.docs;

                    //store document snapshot to  created list
                    chats = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: chats!.length,
                      itemBuilder: (BuildContext context, int index) {
                        String time = chats![index]['time'];
                         print('time is======= ${time}===========');
                        return ListTile(
                          leading: CircleAvatar(
                            // image put whstaspp
                            radius: 30,
                            child: Text(
                                '${chats?[index]['group']}'.substring(0, 1)),
                            // backgroundImage:
                            //     NetworkImage(thisItems['userUrl'])
                          ),

                          title: Text('${chats?[index]['group']}'),
                          subtitle: Text(
                            chats?[index]['last_user'] == ''
                                ? ''
                                : chats?[index]['last_user_email'] ==
                                        FirebaseAuth.instance.currentUser!.email
                                    ? 'You:${chats![index]['last_msg']}'
                                    : '${chats![index]['last_user']}: ${chats![index]['last_msg']}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text('${chats![index]['time']}'),

                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => 
                                Chat1Deatils(
                                  id: chats![index]['id'],
                                  groupName: chats![index]['group'],
                                )
                              )), //navigate to the next page.
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            floatingActionButton: FloatingActionButton(
              backgroundColor: appbarMainColor,
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DemoScreen(),
                ));
                // final groupName = cubit.messageController.text;
                // cubit.addchatRoom(
                //     groupName, DateFormat('hh mm a').format(DateTime.now()));
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => SelectContact(),
                // ));
              },
              child: Icon(
                Icons.chat,
                color: whiteColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
