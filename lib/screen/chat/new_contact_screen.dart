import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_sized_box.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_form_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_widget.dart';

import 'cubit/chat_cubit.dart';

class NewContactScreen extends StatelessWidget {
  const NewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(context),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var cubit = context.read<ChatCubit>();
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
                  text: 'New contact',
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            body: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(cubit.imageUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: IconButton(
                            onPressed: () {
                              cubit.pickImageFromGallery();
                            },
                            icon: Icon(Icons.edit)),
                      )
                    ],
                  ),
                  verticalSizedBox(50),
                  CustomTextFiledWidget(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'First name',
                    controller: cubit.firstNameController,
                    validator: (value) => cubit.firstNameVaildator(value!),
                  ),
                  verticalSizedBox(10),
                  CustomTextFiledWidget(
                    hintText: 'Last name',
                    controller: cubit.lastNameController,
                    validator: (value) => cubit.lastNameVaildator(value!),
                  ),
                  verticalSizedBox(10),
                  CustomTextFiledWidget(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Phone',
                    controller: cubit.phoneController,
                    validator: (value) => cubit.phoneVaildator(value!),
                  ),
                  verticalSizedBox(20),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: appbarMainColor),
                        onPressed: () {
                          cubit.newContactCollection();
                        },
                        child: CustomTextWidget(
                            text: 'Save',
                            color: whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
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
