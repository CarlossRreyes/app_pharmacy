

import 'package:app_pharmacy/config/constans/environment.dart';
import 'package:dio/dio.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class AuthDataSourceImpl extends AuthDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl
    )
  );


  @override
  Future<AuthUser> login(String email, String password) async {
    try {
      final response = await dio.post("/auth/login", data: {
        "email": email,
        "password": password
      });
      final authUser = AuthUserMapper.userJsonToEntity( response.data );                
      return authUser;
    } on DioException catch (e) {

      if( e.response?.statusCode == 401 ){
        throw CustomError( e.response?.data['message']);
      }

      if( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError( "Revisar la conexión a internet" );
      }
      throw Exception();

    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<AuthUser> checkAuthStatus(String token) async{    
    try {
      final response = await dio.get("/auth/checkAuthStatus", options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      ));

      final authUser = AuthUserMapper.userJsonToEntity( response.data );
      return authUser;
    } on DioException catch (e) {

      // if( e.response?.statusCode == 404 ){
      //   throw CustomError( "TOKEN INCORRECTO" );
      // }
      if( e.response?.statusCode == 403 ){
        throw CustomError( "TOKEN INCORRECTO" );
      }
      throw Exception();

    } catch (e) {
      throw Exception();
    }
  }

}