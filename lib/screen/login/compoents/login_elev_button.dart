import 'package:flutter/material.dart';

import '../../../utils/custom_color/custom_color_widget.dart';
import '../../../utils/custom_widget/custom_text_widget.dart';
import '../../Home/home_screen.dart';
import '../cubit/login_cubit.dart';

class LoginElevButton extends StatelessWidget {
  const LoginElevButton({
    super.key,
    required this.cubit,
  });

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: appbarMainColor),
          onPressed: () {
            if (cubit.formKey.currentState!.validate()) {
              cubit.siginUser();
            }
          },
          child: CustomTextWidget(
              text: 'Login',
              color: whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w500)),
    );
  }
}
