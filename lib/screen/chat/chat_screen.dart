import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screen/chat/select_contact.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

import 'models/chat_model.dart';
import 'pages/chat_details.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, this.email}) {
    stream = reference.snapshots();
  }

  String? email;
  var reference = FirebaseFirestore.instance
      .collection('chat_collection')
      .orderBy('time', descending: true);
  late Stream<QuerySnapshot> stream;
  late User userDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              chatAppShowToast(
                  message: 'some error is occured ${snapshot.error}');
            }
            if (snapshot.hasData) {
              QuerySnapshot<Object?>? querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> documents = querySnapshot!.docs;

              List<Map> items = documents
                  .map((e) => {
                        'id': e.id,
                        'name': e['name'],
                        'time': e['time'],
                        'lastMessage': e['lastMessage'],
                        'userUrl': e['userUrl'],
                      })
                  .toList();
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  Map thisItems = items[index];
                  return ListTile(
                    leading: CircleAvatar(
                        // image put whstaspp
                        radius: 30,
                        backgroundImage: NetworkImage(thisItems['userUrl'])),

                    title: Text(thisItems['name']),
                    subtitle: Text(thisItems['lastMessage']),
                    trailing: Text(thisItems['time']),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDeatils(
                            id: thisItems['id'],
                          ),
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
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SelectContact(),
          ));
        },
        child: Icon(
          Icons.chat,
          color: whiteColor,
        ),
      ),
    );
  }
}
