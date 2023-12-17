
import '../domain.dart';

abstract class CategoryDataSource {
  Future<List<Category>> getAllProduct();
}