import 'package:app_pharmacy/config/config.dart';

import 'package:dio/dio.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class CategoryDataSourceImpl extends CategoryDataSource {
  late final Dio dio;
  final String accessToken;

  CategoryDataSourceImpl({
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
  Future<List<Category>> getAllProduct() async{
    try {
      final response = await dio.get("/pharmacy-administration/category/list");
      final List<Category> categories = [];
      for( final category in response.data['data'] ?? [] ){
        categories.add( CategoryMapper.jsonToEntity( category ) );
      }
      return categories;
      
    } on DioException catch (e) {
       if( e.response?.statusCode == 404 ){
        throw CategoryNotFound();
      } 
      throw Exception();
    } catch (e){
      throw Exception();

    }
  }


}