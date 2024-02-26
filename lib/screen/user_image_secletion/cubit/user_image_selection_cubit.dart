import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../firebase_auth_services/auth_services.dart';
import '../../../firebase_auth_services/auth_status_enum.dart';
import '../../../utils/custom_widget/custom_toast_widget.dart';
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
  final FirebaseAuthServices authServices = FirebaseAuthServices();
  AuthStatus authStatus = AuthStatus.notSignedIn;

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
        emit(UserImageSelectionInitial());
      }
    } catch (e) {
      print(e);
    }
  }

  chatTileCollection(String name, String email, String passwrod) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var time = DateFormat('hh:mm a').format(DateTime.now());
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm a').format(now);
    print('------date is-------${formattedDate}-------------');

    User? user =
        await authServices.sigininWithEmailAndPasswrod(email, passwrod);
    if (user != null) {
      chatAppShowToast(message: 'User successfully logined');

      authServices.currentUser().then((userId) {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });

       
      final docRef =
          await FirebaseFirestore.instance.collection('chat_collection').add({
        "name": name,
      });
       
        await docRef.set({
        "id": docRef.id,
        "name": name,
        "time": formattedDate,
        "lastMessage": '',
        "userUrl": imageUrl
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
     
      
    }

    Future<void> addMessage(String id, String message, String time) async {
      final user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('chat_collection')
          .doc(id)
          .collection('message')
          .add({
        "userId": user!.uid,
        "userName": user.displayName,
        "message": message,
        "lastTime": time
      }).then((value) {
        FirebaseFirestore.instance
            .collection('chat_collection')
            .doc(id)
            .update({});
      });
    }

    // Map<String, String> dataToSend = {
    //   'user_id': auth.currentUser!.uid,
    //   'name': name,
    //   'time': formattedDate,
    //   'lastMessage': 'by',
    //   'user_url': imageUrl
    // };
    // ref.add(dataToSend);
  }
}
