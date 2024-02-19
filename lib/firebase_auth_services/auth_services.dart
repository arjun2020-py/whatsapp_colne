import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screen/login/screen_login.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

class FirebaseAuthServices {
  //create the instance of firebase auth
  FirebaseAuth auth = FirebaseAuth.instance;

  //create a function for register the user with firebase auth
  Future<User?> siginupWithEmailAndPasswrod(
      String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-is-allready-in-use') {
        chatAppShowToast(message: 'email id is allready in use');
      } else {
        chatAppShowToast(message: 'some error is occured ${e.code}');
      }
    }
  }

  Future<User?> sigininWithEmailAndPasswrod(
      String email, String password) async {
    //first create the method  for sigin in user.
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-passwrod') {
        chatAppShowToast(message: 'invaild email and passwrod');
      } else {
        chatAppShowToast(message: 'some error is occured ${e.code}');
      }
    }
  }

  Future<String> currentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user!.uid;
  }

  Future siginout(BuildContext context) async {
    await auth.signOut();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }
}
