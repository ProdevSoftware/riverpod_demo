// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_response_model.freezed.dart';
part 'user_response_model.g.dart';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "id")
    int? id,
    @JsonKey(name: "email")
    String? email,
    @JsonKey(name: "password")
    String? password,
    @JsonKey(name: "name")
    String? name,
    @JsonKey(name: "role")
    String? role,
    @JsonKey(name: "avatar")
    String? avatar,
    @JsonKey(name: "creationAt")
    String? creationAt,
    @JsonKey(name: "updatedAt")
    String? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
