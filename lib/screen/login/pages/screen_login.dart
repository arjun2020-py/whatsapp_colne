import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/screen/home/home_screen.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_sized_box.dart';

import '../../../firebase_auth_services/auth_services.dart';
import '../../../utils/custom_widget/custom_text_form_widget.dart';
import '../../../utils/custom_widget/custom_text_widget.dart';
import '../../register/screen_register.dart';
import '../compoents/login_elev_button.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, this.name});

  String? name;
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          var cubit = context.read<LoginCubit>();
          return Scaffold(
              appBar: AppBar(
                backgroundColor: appbarMainColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
                toolbarHeight: 100,
                title: Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: whiteColor,
                      size: 30,
                    ),
                    CustomTextWidget(
                        text: 'WhatsApp ',
                        color: whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        verticalSizedBox(50),
                        CustomTextWidget(
                            text: 'Login to Your Account',
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                            
                        verticalSizedBox(15),
                        CustomTextFiledWidget(
                          controller: cubit.nameController,
                          validator: (value) =>
                              cubit.usernameVaildation(value!),
                          hintText: 'username',
                        ),
                        verticalSizedBox(15),
                        CustomTextFiledWidget(
                          controller: cubit.emailController,
                          validator: (value) => cubit.emailVaildation(value!),
                          hintText: 'email',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFiledWidget(
                          controller: cubit.passwrodController,
                          validator: (value) =>
                              cubit.passwrodVaildation(value!),
                          hintText: 'password',
                        ),
                        verticalSizedBox(10),
                        LoginElevButton(cubit: cubit),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextWidget(
                                text: "Don't have an account",
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ));
                                },
                                child: CustomTextWidget(
                                    text: 'Register ?',
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            horoztalSizedBox(10),
                            Expanded(
                              child: Divider(
                                color: blackColor,
                                thickness: 0.2,
                              ),
                            ),
                            horoztalSizedBox(10),
                            CustomTextWidget(
                                text: 'OR',
                                color: blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                            horoztalSizedBox(10),
                            Expanded(
                              child: Divider(
                                color: blackColor,
                                thickness: 0.2,
                              ),
                            ),
                            horoztalSizedBox(10)
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: whiteColor),
                              onPressed: () {
                                firebaseAuthServices.signInWithGoogle(context);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                color: Colors.red,
                              ),
                              label: Text('')),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
