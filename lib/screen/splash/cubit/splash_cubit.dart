import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp_clone/firebase_auth_services/auth_services.dart';
import 'package:whatsapp_clone/firebase_auth_services/auth_status_enum.dart';
import 'package:whatsapp_clone/screen/home/home_screen.dart';

import '../../login/screen_login.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.context) : super(SplashInitial()) {
      authServices.currentUser().then((userId) {
      authStatus =
          userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
    });
    splash();
  }
  FirebaseAuthServices authServices = FirebaseAuthServices();
  BuildContext context;
  AuthStatus authStatus = AuthStatus.notSignedIn;
  Future<void> splash() async {
    Future.delayed(Duration(seconds: 3), () {
           switch (authStatus) {
        case AuthStatus.notSignedIn:
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
          break;
        case AuthStatus.signedIn:
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen()
          ));
          break;

        default:
      }
   
    });
  }
}
