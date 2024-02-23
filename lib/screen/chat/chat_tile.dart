// import 'package:flutter/material.dart';

// import '../Chat/models/chat_model.dart';
// import '../Chat/pages/chat_details.dart';

// class CustomTileWidget extends StatelessWidget {
//   const CustomTileWidget({
//     super.key,
//     required this.thisItems,
//     required this.userDetails,
//   });

//   final Map thisItems;
//   final User userDetails;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//           // image put whstaspp
//           radius: 30,
//           backgroundImage:
//               AssetImage('assets/images/persion_iocon.jpeg')),
    
//       title: Text(thisItems['name']),
//       subtitle: Text(thisItems['lastMessage']),
//       trailing: Text(thisItems['time']),
//       onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 ChatDeatils(userDetails: userDetails),
//           )), //navigate to the next page.
//     );
//   }
// }