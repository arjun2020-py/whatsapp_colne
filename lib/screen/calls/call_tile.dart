import 'package:flutter/material.dart';

import 'callDetails/call_details.dart';
import 'callmodels/call_model.dart';


class CallTill extends StatelessWidget {
   CallTill({
    Key? key,required this.usercall}) : super(key: key);
 UserCall usercall;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(usercall.image!),
      ),
      title: Text(usercall.name!),
      subtitle: Row(
        children: [
          Text(usercall.updateAt!),
          Icon(Icons.call_missed_outlined)

        ],
      ),
      trailing: Icon((usercall.option!)?Icons.call:Icons.video_call),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CallDetails(details: usercall),)),
      
    );
  }
}
