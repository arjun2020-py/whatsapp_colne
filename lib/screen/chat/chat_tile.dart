import 'package:flutter/material.dart';

import 'models/chat_model.dart';
import 'pages/chat_details.dart';


class ChatTile extends StatelessWidget {
  ChatTile({Key? key, required this.userData}) : super(key: key);
  User userData;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // image put whstaspp
        radius: 30,
        backgroundImage: (userData.image == '')
            ? AssetImage(userData.isGroup!
                ? 'assets/images/Group-icon.png'
                : 'assets/images/persion_iocon.jpeg') as ImageProvider<Object>?
            : NetworkImage(userData.image!),
      ),
      title: Text(userData.name!),
      subtitle: Text(userData.message!),
      trailing: Text(userData.updateAt!),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDeatils(userDetails: userData),
          )), //navigate to the next page.
    );
  }
}
