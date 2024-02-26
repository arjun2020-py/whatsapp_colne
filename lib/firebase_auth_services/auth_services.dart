import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whatsapp_clone/screen/login/pages/screen_login.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_toast_widget.dart';

import '../model/google_sigin_model.dart';
import '../screen/Home/home_screen.dart';

class FirebaseAuthServices {
  //create the instance of firebase auth
  FirebaseAuth auth = FirebaseAuth.instance;

  //create the instance of firebase messaging
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> onBackgroundMessage(RemoteMessage remoteMessage) async {
    print('Title:${remoteMessage.notification?.title}');
    print('Body:${remoteMessage.notification?.body}');
    print('Payload:${remoteMessage.data}');
  }

  //create a function for noftcation

  Future<void> initNotfication() async {
    print('--------------p1');

    //requst persmison from user
    await firebaseMessaging.requestPermission();

    //get firebaseMessage token
    final fcmToken = await firebaseMessaging.getToken();

    print('token=====  ${fcmToken}');
    FirebaseMessaging.onBackgroundMessage(
        (message) => onBackgroundMessage(message));
  }

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

  //google sigin in authication

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Constants.email=googleUser?.email;
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credentical
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential usercred = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );

      return value;
    });
    Constants.email = usercred.user!.email;
    Constants.photoUrl = usercred.user!.photoURL;
    Constants.uid = usercred.user!.uid;
    Constants.username = usercred.user!.displayName;

    var dataFire = await FirebaseFirestore.instance.collection("Users").get();
    var usersList = dataFire.docs;
    bool newUser = true;
    for (int i = 0; i < usersList.length; i++) {
      // print(usersList[i]['email']);
      if (Constants.email == usersList[i]['email']) {
        newUser = false;
      }
    }
    if (newUser == true) {
      FirebaseFirestore.instance.collection("Users").add({
        'email': Constants.email,
        'photoUrl': Constants.photoUrl,
        'uid': Constants.uid,
        'username': Constants.username
      });
    }
    return usercred;
  }
}
