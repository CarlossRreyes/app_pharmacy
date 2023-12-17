import '../../domain/domain.dart';

class SecurityRepositoryImpl extends SecurityRepository{

  final SecurityDataSource dataSource;

  SecurityRepositoryImpl(this.dataSource);

  @override
  Future<User> getUserAuthenticate() {
    return dataSource.getUserAuthenticate();
  }

}