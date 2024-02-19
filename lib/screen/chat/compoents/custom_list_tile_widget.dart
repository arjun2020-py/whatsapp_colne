import 'package:flutter/material.dart';

import '../../../utils/custom_color/custom_color_widget.dart';
import '../../../utils/custom_widget/custom_text_widget.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    required this.text,
    required this.icons,
    required this.onTap
  });
  final IconData icons;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap:onTap ,
      leading: Container(
          width: 50,
          height: 50,
          decoration: ShapeDecoration(
              color: appbarMainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          child: Icon(
            icons,
            color: whiteColor,
          )),
      title: CustomTextWidget(
          text: text,
          color: blackColor,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }
}
