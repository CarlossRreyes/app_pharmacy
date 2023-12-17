

import 'package:app_pharmacy/features/category/domain/domain.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {

  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {

    return  Center(
      child: Card(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Center(
            child: Text( category.name, textAlign: TextAlign.center, )
          ),
        ),
      ),
    );
    // return Column(
    //   children: [
    //     Text( category.name, textAlign: TextAlign.center, )
    //   ],
    // );
  }
}