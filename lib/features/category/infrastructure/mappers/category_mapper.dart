



import '../../domain/domain.dart';

class CategoryMapper {
    static jsonToEntity( Map<String, dynamic> json ) => Category(
    id: json['id_category'],
    name: json['name'] ,
    description: json['description'],
    //TODO: CORRECT IMAGE 
    image: json['image'] ,
    state: json['state']     
  );
}