import '../entities/auth_user.dart';

abstract class AuthRepository {

  Future<AuthUser>login( String email, String password );
  // Future<User>register( String email, String password );
  Future<AuthUser>checkAuthStatus( String token );
}