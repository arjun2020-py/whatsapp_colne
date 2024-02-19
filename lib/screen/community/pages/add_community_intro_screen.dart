import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screen/home/home_screen.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_sized_box.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_widget.dart';

import 'new_community_screen.dart';

class CommunityIntroScreen extends StatelessWidget {
  const CommunityIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Card(
            color: whiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close)),
                verticalSizedBox(50),
                Center(child: Image.asset('assets/images/community.png')),
                verticalSizedBox(10),
                Center(
                  child: CustomTextWidget(
                      text: 'Create a new community',
                      color: blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5, top: 5),
                  child: CustomTextWidget(
                      text:
                          'WhatsApp communities is a feature within WhatsApp that allows users to quickly sort common groups into large ones, similar to a virtual community. You can create \n communities for different use cases.',
                      color: blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                verticalSizedBox(100),
                Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: appbarMainColor),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                        },
                        child: CustomTextWidget(
                            text: 'Get started',
                            color: whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
