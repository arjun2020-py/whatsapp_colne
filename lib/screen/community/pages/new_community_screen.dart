import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';

class NewCommunityScreen extends StatelessWidget {
  const NewCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarMainColor,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Stack(
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
        ],
      ),
    );
  }
}
