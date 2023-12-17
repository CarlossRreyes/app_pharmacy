

import 'package:dio/dio.dart';
import '../../../../config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class SecurityDataSourceImpl extends SecurityDataSource{

  
  late final Dio dio;
  final String accessToken;

  SecurityDataSourceImpl({
    required this.accessToken
  }): dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );


  @override
  Future<User> getUserAuthenticate() async{    
    try {
      final response = await dio.get("/pharmacy-security/permission/userAuthenticate");
      final userDetails = UserDetails.fromJson( response.data['data']['user'] );
      final user = UserMapper.userDetailsToEntity(userDetails);
      return user;

    } on DioException catch (e) {
      if( e.response?.statusCode == 404 ){
        throw CustomError( e.response?.data['message']);
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

}