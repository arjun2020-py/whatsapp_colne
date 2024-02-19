import 'package:flutter/material.dart';

import 'models/status_model.dart';


class StatusTile extends StatelessWidget {
  StatusTile({Key? key, required this.userData}) : super(key: key);
 UserStatus  userData;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // image put whstaspp
        radius: 30,
        backgroundImage : NetworkImage(userData.image!),
      ),
      title: Text(userData.name!),
      subtitle: Text(userData.updateAt!),
    );
  }
}
