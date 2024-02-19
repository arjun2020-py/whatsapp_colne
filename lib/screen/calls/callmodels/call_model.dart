// To parse this JSON data, do
//
//     final userCall = userCallFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final userCall = userCallFromJson(jsonString);

import 'dart:convert';

UserCall userCallFromJson(String str) => UserCall.fromJson(json.decode(str));

String userCallToJson(UserCall data) => json.encode(data.toJson());

class UserCall {
    UserCall({
        this.image,
        this.name,
        this.updateAt,
        this.option,
        this.calltpe,
    });

    String? image;
    String? name;
    String? updateAt;
    bool? option;
    bool? calltpe;

    factory UserCall.fromJson(Map<String, dynamic> json) => UserCall(
        image: json["image"],
        name: json["name"],
        updateAt: json["updateAt"],
        option: json["option"],
        calltpe: json["calltpe"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "updateAt": updateAt,
        "option": option,
        "calltpe": calltpe,
    };
}
