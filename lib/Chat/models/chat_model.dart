// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.naame,
        this.message,
        this.image,
        this.isGroup,
        this.updateAt,
    });

    String? naame;
    String? message;
    String? image;
    bool? isGroup;
    String? updateAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        naame: json["naame"],
        message: json["message"],
        image: json["image"],
        isGroup: json["isGroup"],
        updateAt: json["updateAt"],
    );

    Map<String, dynamic> toJson() => {
        "naame": naame,
        "message": message,
        "image": image,
        "isGroup": isGroup,
        "updateAt": updateAt,
    };
}
