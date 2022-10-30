// To parse this JSON data, do
//
//     final chatBable = chatBableFromJson(jsonString);

import 'dart:convert';

ChatBable chatBableFromJson(String str) => ChatBable.fromJson(json.decode(str));

String chatBableToJson(ChatBable data) => json.encode(data.toJson());

class ChatBable {
    ChatBable({
        this.isSend,
        this.isReaded,
        this.message,
        this.sendAt,
    });

    bool? isSend;
    bool? isReaded;
    String? message;
    String? sendAt;

    factory ChatBable.fromJson(Map<String, dynamic> json) => ChatBable(
        isSend: json["isSend"],
        isReaded: json["isReaded"],
        message: json["message"],
        sendAt: json["sendAt"],
    );

    Map<String, dynamic> toJson() => {
        "isSend": isSend,
        "isReaded": isReaded,
        "message": message,
        "sendAt": sendAt,
    };
}
