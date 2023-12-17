import '../../domain/domain.dart';

class AuthUserMapper {

  static AuthUser userJsonToEntity (Map<String, dynamic> json ) => AuthUser(
    status: json['status'], 
    message: json['message'], 
    token: json['token']
  );
}