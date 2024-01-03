import 'package:teslo_shop/features/auth/domain/domain.dart';

class UserMapper {
  static User usersonToEntity(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        fullname: json['fullName'],
        roles: List<String>.from(json['roles'].map((role) => role)),
        token: json['token'],
      );
}
