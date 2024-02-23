import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/user_image_selection_cubit.dart';

class UserSelectionImage extends StatelessWidget {
  UserSelectionImage({super.key, required this.name,});
  String name;
 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserImageSelectionCubit(context),
      child: BlocBuilder<UserImageSelectionCubit, UserImageSelectionState>(
        builder: (context, state) {
          var cubit = context.read<UserImageSelectionCubit>();
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(cubit.imageUrl),
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.pickImageFromGallery();
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent),
                      onPressed: () {
                        cubit.chatTileCollection(name);
                      },
                      child: Text('pick image'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
