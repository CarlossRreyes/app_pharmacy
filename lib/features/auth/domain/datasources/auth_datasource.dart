

import '../entities/auth_user.dart';

abstract class AuthDataSource {

  Future<AuthUser>login( String email, String password );
  // Future<User>register( String email, String password );
  Future<AuthUser>checkAuthStatus( String token );
}