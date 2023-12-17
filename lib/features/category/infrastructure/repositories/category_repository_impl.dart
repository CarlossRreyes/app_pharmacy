
import '../../domain/domain.dart';

class CategoryRepositoryImpl extends CategoryRepository{

  final CategoryDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<Category>> getAllProduct() {
    return dataSource.getAllProduct();
  }
  
}