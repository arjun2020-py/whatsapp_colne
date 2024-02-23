import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../Home/home_screen.dart';

part 'user_image_selection_state.dart';

class UserImageSelectionCubit extends Cubit<UserImageSelectionState> {
  UserImageSelectionCubit(this.context) : super(UserImageSelectionInitial());
  CollectionReference ref =
      FirebaseFirestore.instance.collection('chat_tile_collection');
  BuildContext context;
  File? imageFile;
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  String imageUrl = '';
  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    try {
      if (image != null) {
        imageFile = File(image.path);
        print('image url is ${imageFile}');

        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('images');

        Reference referenceImageToUpload =
            referenceDirImages.child(uniqueFileName);

        await referenceImageToUpload.putFile(imageFile!);

        imageUrl = await referenceImageToUpload.getDownloadURL();
        print('pick image ----==----${imageUrl}}');
      }
    } catch (e) {
      print(e);
    }
  }

  chatTileCollection(String name,) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var time = DateFormat('hh:mm a').format(DateTime.now());
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm a').format(now);
    print('------date is-------${formattedDate}-------------');

    Map<String, String> dataToSend = {
      'user_id': auth.currentUser!.uid,
      'name': name,
      'time': formattedDate,
      'lastMessage': 'by',
      'user_url': imageUrl
    };
    ref.add(dataToSend);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
