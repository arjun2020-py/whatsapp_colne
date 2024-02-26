import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String? username;
  final String message;
  final String? dpURL;
  final bool isMe;
  const MessageBubble({
    Key? key,
    required this.username,
    required this.message,
    required this.dpURL,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              minWidth: w * 0.01,
              maxWidth: w * 0.5,
            ),
            padding: EdgeInsets.only(
              left: isMe ? w * 0.03 : w * 0.02,
              right: isMe ? w * 0.02 : w * 0.03,
              top: h * 0.005,
              bottom: h * 0.01,
            ),
            decoration: BoxDecoration(
              color: isMe ? Color(0xff650088) : Color(0xffF2CCFF),
              borderRadius: isMe
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(
                        w * 0.05,
                      ),
                    )
                  : BorderRadius.only(
                      bottomRight: Radius.circular(
                        w * 0.05,
                      ),
                    ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: w * 0.03,
                      backgroundImage: NetworkImage(dpURL!),
                    ),
                    SizedBox(
                      width: w * 0.01,
                    ),
                    Flexible(
                      child: Text(
                        username!,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          color: isMe ? Color(0xffF8E5FF) : Color(0xff650088),
                          fontWeight: FontWeight.w600,
                          fontSize: w * 0.05,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: h * 0.012,
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: isMe ? Colors.white : Color(0xff650088),
                    fontWeight: FontWeight.w400,
                    fontSize: w * 0.04,
                  ),
                )
              ],
            ),
          ),
        ]);
  }
}
