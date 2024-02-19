import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screen/login/screen_login.dart';

import '../../../utils/custom_color/custom_color_widget.dart';
import '../../../utils/custom_widget/custom_text_widget.dart';
import '../../Home/home_screen.dart';
import '../cubit/register_cubit.dart';

class RegisterElevButton extends StatelessWidget {
  const RegisterElevButton({
    super.key,
    required this.cubit,
  });

  final RegisterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: appbarMainColor),
          onPressed: () {
            if (cubit.formKey.currentState!.validate()) {
              cubit.registerUser();
             
            }
          },
          child: CustomTextWidget(
              text: 'Register',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w500)),
    );
  }
}
