import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.context) : super(ChatInitial());
  BuildContext context;
  TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? imageFile;

  firstNameVaildator(String value) {
    if (value != null) {
      return 'enter vaild first name';
    }
  }

  lastNameVaildator(String value) {
    if (value != null) {
      return 'enter vaild last name';
    }
  }

  phoneVaildator(String value) {
    if (value != null) {
      return 'enter vaild phone number';
    }
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      print('image url is ${imageFile}');
    }
  }
}
