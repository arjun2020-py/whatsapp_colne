import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_widget.dart';

import 'add_community_intro_screen.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: SizedBox(
              width: 60,
              height: 60,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CommunityIntroScreen()));
                },
                child: 
                Card(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Center(
                        child: Icon(
                          Icons.groups_2_rounded,
                          size: 25,
                        ),
                      ),
                      Icon(
                        Icons.add_box_rounded,
                        color: greenColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            title: CustomTextWidget(
                text: 'New Community',
                color: blackColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Divider(
            thickness: 0.1,
            color: blackColor,
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/Group-icon.png'),
                  ),
                  // leading: Text('community image'),
                  title: Text('community name'),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: blackColor,
                  thickness: 0.1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
