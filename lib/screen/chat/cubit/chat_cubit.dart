import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.context) : super(ChatInitial()) {
    getShredPF();
  }
  BuildContext context;
  TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      messageController = TextEditingController(),
      phoneController = TextEditingController();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('new_contact_collection');

  CollectionReference messageRefe =
      FirebaseFirestore.instance.collection('message_collection');

  final formKey = GlobalKey<FormState>();

  File? imageFile;
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  String imageUrl = '';
  var email;
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

    try {
      if (image != null) {
        imageFile = File(image.path);
        print('image url is ${imageFile}');

        // Get the reference to storage root
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('images');

        //create a reference for the image to be stored
        Reference referenceImageToUpload =
            referenceDirImages.child(uniqueFileName);

        await referenceImageToUpload.putFile(imageFile!);
        //success: get the download URL.
        imageUrl = await referenceImageToUpload.getDownloadURL();
        print('pick image ----==----${imageUrl}}');
      }
    } catch (e) {
      print(e);
    }
  }

  newContactCollection() async {
    print('---------------pick image is    ${imageUrl}---------------');
    var firstName = firstNameController.text;
    var lastName = lastNameController.text;
    var mobile = phoneController.text;

    var time = DateFormat('hh:mm a').format(DateTime.now());
    Map<String, String> dataToSend = {
      'firstName': firstName,
      'laetName': lastName,
      'mobile': mobile,
      'createdTime': time,

      'imagePAth': imageUrl
    };
    collectionReference.add(dataToSend);
    Navigator.of(context).pop();
  }

  getShredPF() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString('email');
    print('----------email----${email}---------');
  }

  // messageCollection() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   String message = messageController.text;
  //   var time = DateFormat('hh:mm a').format(DateTime.now());
  //   Map<String, String> dataToSend = {
  //     "add_time": time,
  //     "content": message,
  //     "type": email,
  //     "user_id": auth.currentUser!.uid
  //   };
  //   messageRefe.add(dataToSend);
  //   messageController.clear();
  // }
}
