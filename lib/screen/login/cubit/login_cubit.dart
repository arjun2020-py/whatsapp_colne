import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp_clone/screen/home/home_screen.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

import '../../../firebase_auth_services/auth_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.context) : super(LoginInitial());
  BuildContext context;
  TextEditingController emailController = TextEditingController(),
      passwrodController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final FirebaseAuthServices authServices = FirebaseAuthServices();

  usernameVaildation(String value) {
    if (value.isEmpty) {
      return 'please enter vaild username';
    }
  }

  passwrodVaildation(String value) {
    if (value.isEmpty) {
      return 'please enter vaild passwrod';
    }
  }

  siginUser() async {
    String email = emailController.text;
    String passwrod = passwrodController.text;
    User? user =
        await authServices.sigininWithEmailAndPasswrod(email, passwrod);
    if (user != null) {
      chatAppShowToast(message: 'User successfully logined');
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    }
  }
}
