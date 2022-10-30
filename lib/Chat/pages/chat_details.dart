import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Chat/models/single_chat_model.dart';
import 'package:whatsapp_clone/Chat/pages/chat_babble.dart';

import '../models/chat_model.dart';

class ChatDeatils extends StatefulWidget {
  ChatDeatils({super.key, required this.userDetails});
  User userDetails;

  @override
  State<ChatDeatils> createState() => _ChatDeatilsState();
}

class _ChatDeatilsState extends State<ChatDeatils> {
  //create instance  of user
  final _messageConntroller = TextEditingController();

  bool showSent = false;

  bool showEmoji = false; //emjio in whatsapp

  FocusNode focusNode = FocusNode();
  List<ChatBable> chatb = [
    ChatBable(
        isSend: true, isReaded: true, message: "hi macha", sendAt: "08:00pm"),
    ChatBable(
        isSend: false,
        isReaded: true,
        message: "good after noon",
        sendAt: "8:05pm"),
    ChatBable(
        isSend: true,
        isReaded: true,
        message: "how are you",
        sendAt: "08:08pm"),
    ChatBable(
        isSend: false, isReaded: true, message: "iam fine", sendAt: "08:10pm"),
    ChatBable(
        isSend: true,
        isReaded: true,
        message: "same to you bro",
        sendAt: "08:15pm"),
    ChatBable(
        isSend: false,
        isReaded: true,
        message: "what about feature plain",
        sendAt: "08:18pm"),
    ChatBable(
        isSend: true,
        isReaded: true,
        message: "nothing bro",
        sendAt: "08:20pm"),
    ChatBable(isSend: false, isReaded: true, message: "ok", sendAt: "08:25pm")
  ];
  var datetime = DateTime.now();

  void _setBabble() {
    //pass mesaage from user side
    var time = '${datetime.hour}:${datetime.minute} am';
    setState(() {
      chatb.add(ChatBable(
          isSend: true,
          isReaded: true,
          message: _messageConntroller.text,
          sendAt: time));
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 110, //provide
        leading: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                    Icons.arrow_back)), //pop is used go back to home page
            CircleAvatar(
              radius: 30,
              backgroundImage: (widget.userDetails.image == "")
                  ? AssetImage(widget.userDetails.isGroup!
                          ? "assets/images/Group-icon.png"
                          : "assets/images/persion_iocon.jpeg")
                      as ImageProvider<Object>?
                  : NetworkImage(widget.userDetails.image!),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.userDetails.naame.toString()),
            const Text("online")
          ],
        ),
        actions: [
          const Icon(Icons.video_call),
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.call),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text(widget.userDetails.isGroup == true
                    ? 'group info'
                    : "Add to conatacts"),
              ),
              PopupMenuItem(
                  child: Text(widget.userDetails.isGroup == true
                      ? "Group media"
                      : "Media,links, and docs")),
              PopupMenuItem(child: Text("Serach")),
              PopupMenuItem(child: Text("Mute notfications")),
              PopupMenuItem(child: Text("Disappering messgaes")),
              PopupMenuItem(child: Text("Wallpaper")),
              PopupMenuItem(child: Text("More")),
              // PopupMenuItem(child: child)
            ];
          }),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset("assets/images/w.jpeg",
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover),
            ListView.builder(
              itemCount: chatb.length,
              itemBuilder: (BuildContext context, int index) {
                return ChatBabble(bable: chatb[index]);
              },
            ),
            //text filed and button
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20)), //it provide cricle edge in card
                          child: TextField(
                            focusNode:focusNode,
                            onTap: () {
                              setState(() {
                                showEmoji = false;
                              });
                            },
                            controller: _messageConntroller,
                            onChanged: (value) {
                              //mesage button is avilable only
                              if (value.length > 0) {
                                setState(() {
                                  showSent = true;
                                });
                              } else {
                                setState(() {
                                  showSent = false;
                                });
                              }
                              print(value);
                            },
                            decoration: InputDecoration(
                              hintText: "mesaage",
                              prefixIcon: IconButton(
                                  onPressed: () {
                                    showEmoji? focusNode.unfocus(): focusNode.hasFocus;
                                    setState(() {
                                      showEmoji=! showEmoji;
                                      showEmoji?FocusManager.instance.primaryFocus?.unfocus():focusNode.requestFocus();
                                      //change emoji to keyboard
                                    });
                                  },
                                  icon: Icon(showEmoji
                                      ? Icons.keyboard
                                      : Icons.emoji_emotions_outlined)),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Icon(Icons.attach_file),
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) => menu(),
                                        ); //used to popup from the screen
                                      },
                                      icon: const Icon(Icons.attach_file)),
                                  // const Icon(Icons.currency_rupee),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.currency_rupee)),
                                  const Icon(Icons.camera_alt),
                                  //  IconButton(onPressed: onPressed, icon: icon) ,
                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          _setBabble();
                          _messageConntroller.clear();
                        },
                        child:
                            Icon((showSent == true) ? Icons.send : Icons.mic),
                      )
                    ],
                  ),
                  Offstage(
                    offstage:!showEmoji ,
                    child:  SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        textEditingController: _messageConntroller,
                        
                      ),
                    ),
                  ),
                ],
              ),
            ), //chnage the postion wedgit in flutter
          ],
        ),
      ),
    );
  }

//menu section for pin
  Container menu() {
    return Container(
      height: 400,
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20), //
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                iconWedgit(
                    icon: const Icon(Icons.insert_drive_file),
                    color: Colors.purple,
                    text: "Document"),
                iconWedgit(
                    icon: Icon(Icons.camera_alt),
                    color: Colors.pink,
                    text: "Camera"),
                iconWedgit(
                    icon: Icon(Icons.insert_photo),
                    color: Colors.purple,
                    text: "Gallery")
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                iconWedgit(
                    icon: Icon(Icons.headset),
                    color: Colors.orange,
                    text: "Audio"),
                iconWedgit(
                    icon: Icon(Icons.location_pin),
                    color: Colors.green,
                    text: "Location"),
                iconWedgit(
                    icon: Icon(Icons.currency_rupee),
                    color: Colors.blue,
                    text: "Pyment"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  iconWedgit(
                      icon: Icon(Icons.contacts),
                      color: Colors.blue,
                      text: "Contact")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//funcation parmter
  Column iconWedgit({
    String? text,
    Icon? icon,
    Color? color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: icon,
        ),
        SizedBox(
          height: 10,
        ),
        Text(text!),
      ],
    );
  }
}
//code from emoji picker
// Widget selectEmoji(){
//     return EmojiPicker(onEmojiSelected: (emoji, category) {
      
//     },);
// }
