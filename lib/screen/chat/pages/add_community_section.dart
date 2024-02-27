import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_sized_box.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_form_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_widget.dart';

import '../cubit/chat_cubit.dart';

class AddNewCommunity extends StatelessWidget {
  const AddNewCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(context),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var cubit = context.read<ChatCubit>();
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/community.png'),
                  verticalSizedBox(20),
                  CustomTextWidget(
                      text: 'Add New community',
                      color: blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                  verticalSizedBox(10),
                  CustomTextFiledWidget(
                    hintText: 'enter  name',
                    controller: cubit.messageController,
                    validator: (value) {
                      var groupName = cubit.messageController.text;

                      cubit.addchatRoom(groupName,
                          DateFormat("hh mm a").format(DateTime.now()));
                      print('---------group is created');
                    },
                  ),
                  verticalSizedBox(10),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.addchatRoom(cubit.messageController.text,
                            DateFormat('hh mm a').format(DateTime.now())); 
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: whiteColor),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: appbarMainColor),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
