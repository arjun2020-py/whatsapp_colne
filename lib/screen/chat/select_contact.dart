import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_sized_box.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_widget.dart';

import 'compoents/custom_list_tile_widget.dart';
import 'new_contact_screen.dart';

class SelectContact extends StatelessWidget {
  const SelectContact({super.key});

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
      body: Column(
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NewContactScreen()));
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
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/persion_iocon.jpeg'),
                  ),
                  title: CustomTextWidget(
                      text: 'Arun',
                      color: blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
