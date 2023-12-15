import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class UserAccount {
  final String userUid;
  final String displayName;
  final String email;
  final String password;
  final String imgUrl;
  UserAccount({
    required this.userUid,
    required this.displayName,
    required this.email,
    required this.password,
    required this.imgUrl
  });
  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _$UserAccountFromJson(json);
  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
 
}
