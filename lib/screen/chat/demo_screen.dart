import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_form_widget.dart';

import 'cubit/chat_cubit.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(context),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var cubit = context.read<ChatCubit>();
          return Scaffold(
            body: Form(
              key: cubit.formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/community.png'),
                    CustomTextFiledWidget(
                        hintText: 'enter message',
                        controller: cubit.groupNameController,
                        validator: (value) => cubit.groupNameVaildtor(value!)),
                    ElevatedButton(
                        onPressed: () async {
                          String groupName = cubit.groupNameController.text;
                          String time =
                              DateFormat('hh mm a').format(DateTime.now());
                          print('------------------------------------p1');
                          print(
                              '-----------add chat room time is  ${time}----------');
                          cubit.addchatRoom(groupName, time);
                        },
                        child: Text('submit'))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
