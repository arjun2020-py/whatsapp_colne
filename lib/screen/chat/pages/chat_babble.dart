import 'package:flutter/material.dart';

import '../models/single_chat_model.dart';

class ChatBabble extends StatelessWidget {
  ChatBabble({super.key, required this.bable});
  ChatBable bable;
  @override
  Widget build(BuildContext context) {
    return 
    Align(
        alignment: bable.isSend!
            ? Alignment.centerRight
            : Alignment
                .centerLeft, // align chat in whatsapp using single line function
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 150), //important
          child: Card(
            color: bable.isSend! ? Color(0xffdcf8c6) : Colors.white,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 7, right: 58, bottom: 10),
                  child: Text(bable.message!),
                ),
                Positioned(
                  bottom: 3,
                  right: 2,
                  child: Row(
                    children: [
                      Text(
                        bable.sendAt!,
                        style: const TextStyle(fontSize: 10),
                      ),
                      if (bable.isSend!)
                        Icon(
                          Icons.done_all,
                          color: bable.isReaded! ? Colors.blue : Colors.grey,
                          size: 14,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
