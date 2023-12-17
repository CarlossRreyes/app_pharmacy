import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/provider.dart';
import '../widgets/widgets.dart';


class CategoriesScreen extends StatelessWidget {
  static const name = "category-screen";
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(
      //   title:  const Text("Categorías"),
      // ),
      body:const _CategoriesView(),
    );
  }
}

class _CategoriesView extends ConsumerStatefulWidget {
  const _CategoriesView();

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
  
}

class _CategoriesViewState extends ConsumerState {

  void showSnackbar( BuildContext context, String message ){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text( message ))
    );
  }



  @override
  Widget build(BuildContext context) {

    final categoriesState = ref.watch( categoriesProvider );

    ref.listen( categoriesProvider, (previous, next) {      
      if( next.errorMessage.isEmpty ) return;
      showSnackbar(context, next.errorMessage );
    });


    return  Padding(
      padding: const EdgeInsets.symmetric( horizontal: 10 ),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: categoriesState.categories.length,
        itemBuilder: (context, index) {
          final category = categoriesState.categories[index];
          if( index == 1 ){
            return Column(
              children: [
                const SizedBox( height: 40,),
                CategoryCard(category: category),
              ],
            );
          }

          return CategoryCard(category: category);


          // final category = categoriesState.categories[index];
          // return GestureDetector(
          //   onTap: null,
          //   child: CategoryCard(category: category),
          // );
        },

        
      ),

    );
  }
}