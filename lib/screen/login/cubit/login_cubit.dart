import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/screen/home/home_screen.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

import '../../../firebase_auth_services/auth_services.dart';
import '../../user_image_secletion/user_selection.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.context) : super(LoginInitial());
  BuildContext context;
  TextEditingController emailController = TextEditingController(),
      nameController = TextEditingController(),
      passwrodController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final FirebaseAuthServices authServices = FirebaseAuthServices();
  CollectionReference ref =
      FirebaseFirestore.instance.collection('chat_tile_collection');
  usernameVaildation(String value) {
    if (value.isEmpty) {
      return 'please enter vaild username';
    }
  }

  emailVaildation(String value) {
    if (value.isEmpty) {
      return 'please enter vaild email';
    }
  }

  passwrodVaildation(String value) {
    if (value.isEmpty) {
      return 'please enter vaild passwrod';
    }
  }

  siginUser() async {
    String name = nameController.text;
    String email = emailController.text;
    String passwrod = passwrodController.text;

    User? user =
        await authServices.sigininWithEmailAndPasswrod(email, passwrod);
    if (user != null) {
      chatAppShowToast(message: 'User successfully logined');
      setStringSF(email);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UserSelectionImage(
          name: name,
        ),
      ));
    }
  }

  setStringSF(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', email);
  }
}
