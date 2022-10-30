// To parse this JSON data, do
//
//     final userStatus = userStatusFromJson(jsonString);

import 'dart:convert';

UserStatus userStatusFromJson(String str) => UserStatus.fromJson(json.decode(str));

String userStatusToJson(UserStatus data) => json.encode(data.toJson());

class UserStatus {
    UserStatus({
        this.image,
        this.name,
        this.updateAt,
    });

    String? image;
    String? name;
    String? updateAt;

    factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        image: json["image"],
        name: json["name"],
        updateAt: json["updateAt"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "updateAt": updateAt,
    };
}
