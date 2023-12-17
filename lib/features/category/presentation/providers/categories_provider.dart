// import 'package:app_pharmacy/features/category/infrastructure/infrastructure.dart';
import 'package:app_pharmacy/features/category/presentation/providers/category_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';


final categoriesProvider = StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  final categoryRepository = ref.watch( categoryRepositoryProvider );
  return CategoryNotifier(categoryRepository: categoryRepository);
});

class CategoryNotifier extends StateNotifier<CategoryState> {

  final CategoryRepository categoryRepository;

  CategoryNotifier({
    required this.categoryRepository
  }): super( CategoryState() ){
    loadNextPage();
  }

  Future loadNextPage() async {

    if( state.isLoading ) return;
    try {
      state = state.copyWith( isLoading:  true );
      final categories = await categoryRepository.getAllProduct();
      if( categories.isEmpty ){
        state = state.copyWith(
          isLoading: false
        );
        return;
      }
      state = state.copyWith(
        isLoading: false,
        categories: [ ...state.categories, ...categories ] 
      );
      
    } catch (e){
      print(e);
    }
    // on DioException catch (e) {
    //   state = state.copyWith(
    //     errorMessage: e.message,
    //     categories: null
    //   );
    // }
    

  }
  
}

//TODO: CATEGORY STATE
class CategoryState {
    // final bool isLastPage;
    // final int limit;
    // final int offset;
  final bool isLoading;
  final List<Category> categories;
  final String errorMessage;

  CategoryState({
    this.isLoading = false, 
    this.categories = const [],
    this.errorMessage = ""
  });

  CategoryState copyWith({
    bool? isLoading,
    List<Category>? categories,
    String? errorMessage
  }) => CategoryState(
    isLoading: isLoading ?? this.isLoading, 
    categories: categories ?? this.categories,
    errorMessage: errorMessage ?? this.errorMessage,
  );



}