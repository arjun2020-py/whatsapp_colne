import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/utils/custom_color/custom_color_widget.dart';
import 'package:whatsapp_clone/utils/custom_widget/custom_text_widget.dart';

import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          var cubit = context.read<SplashCubit>();
          return Scaffold(
            backgroundColor: blackColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Container(
                    child: FaIcon(FontAwesomeIcons.whatsapp,
                        size: 90, color: whiteColor)),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                        child: CustomTextWidget(
                            text: 'from',
                            color: whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)),
                    Container(
                      child: Center(
                          child: CustomTextWidget(
                              text: 'Meta',
                              color: whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.normal)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
