import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screen/login/pages/screen_login.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

import '../../../firebase_auth_services/auth_services.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.context) : super(RegisterInitial());

  BuildContext context;

  TextEditingController emailController = TextEditingController(),
      nameController = TextEditingController(),
      mobileContoller = TextEditingController(),
      passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final FirebaseAuthServices authServices = FirebaseAuthServices();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user_collection');

  usernameVaildation(String value) {
    if (value.isEmpty) {
      return 'please enter vaild username';
    }
  }

  nameVaildation(String value) {
    if (value.isEmpty) {
      return 'please enter vaild name';
    }
  }

  mobileVaildation(String value) {
    if (value.isEmpty) {
      return 'please enter vaild mobile no';
    }
  }

  passwrodVaildation(String value) {
    if (value.isEmpty) {
      return 'please enter vaild passwrod';
    }
  }

  registerUser() async {
    String email = emailController.text;
    String name = nameController.text;
    String mobile = mobileContoller.text;
    String password = passwordController.text;

    Map<String, String> dataToSend = {
      'email': email,
      'name': name,
      'mobile': mobile,
      'password': password
    };
    collectionReference.add(dataToSend);
    
    User? user =
        await authServices.siginupWithEmailAndPasswrod(email, password);

    if (user != null) {
      chatAppShowToast(message: 'User siginup succssfully');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
