// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
      userUid: json['userUid'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      imgUrl: json['imgUrl'] as String,
    );

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'userUid': instance.userUid,
      'displayName': instance.displayName,
      'email': instance.email,
      'password': instance.password,
      'imgUrl': instance.imgUrl,
    };
