import '../../domain/domain.dart';
import '../infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource dataSource;

  AuthRepositoryImpl({
    AuthDataSource? dataSource
  }): dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<AuthUser> login(String email, String password) {
    return dataSource.login(email, password);
  }
  
  @override
  Future<AuthUser> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

}