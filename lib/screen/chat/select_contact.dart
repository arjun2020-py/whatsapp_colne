import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_sized_box.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

import 'compoents/custom_list_tile_widget.dart';
import 'new_contact_screen.dart';

class SelectContact extends StatelessWidget {
  SelectContact({super.key}) {
    stream = reff.snapshots();
  }

  final reff = FirebaseFirestore.instance
      .collection('new_contact_collection')
      .orderBy('createdTime');
  late Stream<QuerySnapshot> stream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarMainColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            )),
        title: CustomTextWidget(
            text: 'Select contact',
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        actions: [
          Icon(
            Icons.search,
            color: whiteColor,
          ),
          PopupMenuButton(
            color: whiteColor,
            iconColor: Colors.white,
            itemBuilder: (context) {
              return const [
                PopupMenuItem(child: Text("Invite a friend")),
                PopupMenuItem(child: Text("Contacts")),
                PopupMenuItem(child: Text("Refersh")),
                PopupMenuItem(child: Text("Help")),
              ];
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              chatAppShowToast(
                  message: 'some error is occured ${snapshot.error}');
            }
            if (snapshot.hasData) {
              //create instance of query sanpshot
              QuerySnapshot<Object?>? querySnapshot = snapshot.data;
              //create instance QueryDocumentSanphot
              List<QueryDocumentSnapshot> document = querySnapshot!.docs;
              // convert documents in to map of list.

              List<Map> items = document
                  .map((e) => {
                        'firstName': e['firstName'],
                        'laetName': e['laetName'],
                        'mobile': e['mobile'],
                        'imagePAth': e['imagePAth']
                      })
                  .toList();

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomListTileWidget(
                    icons: Icons.groups_2_rounded,
                    text: 'New group',
                    onTap: () {},
                  ),
                  verticalSizedBox(20),
                  CustomListTileWidget(
                    icons: Icons.person_outline_rounded,
                    text: 'New contact',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewContactScreen()));
                    },
                  ),
                  verticalSizedBox(20),
                  CustomListTileWidget(
                    icons: Icons.groups_3_rounded,
                    text: 'New community',
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: CustomTextWidget(
                        text: 'Contacts on WhatsApp',
                        color: blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = items[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['imagePAth']),
                          ),
                          title: CustomTextWidget(
                              text: data['firstName'],
                              color: blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
