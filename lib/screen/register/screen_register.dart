import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/custom_color/custom_color_widget.dart';
import '../../utils/custom_widget/custom_text_form_widget.dart';
import '../../utils/custom_widget/custom_text_widget.dart';
import '../login/screen_login.dart';
import 'compoents/register_elev_button.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(context),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          var cubit = context.read<RegisterCubit>();
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
              body: SafeArea(
                child: Form(
                  key: cubit.formKey,
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextWidget(
                              text: 'Create a New Account',
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFiledWidget(
                            controller: cubit.emailController,
                            validator: (value) =>
                                cubit.usernameVaildation(value!),
                            hintText: 'email',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFiledWidget(
                            controller: cubit.nameController,
                            validator: (value) =>
                                cubit.usernameVaildation(value!),
                            hintText: 'username',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFiledWidget(
                            controller: cubit.mobileContoller,
                            validator: (value) =>
                                cubit.mobileVaildation(value!),
                            hintText: 'mobile',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFiledWidget(
                            controller: cubit.passwordController,
                            validator: (value) =>
                                cubit.passwrodVaildation(value!),
                            hintText: 'password',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                         RegisterElevButton(cubit: cubit,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextWidget(
                                  text: "All ready have an account",
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                          name: cubit.nameController.text),
                                    ));
                                  },
                                  child: CustomTextWidget(
                                      text: 'Login ?',
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
