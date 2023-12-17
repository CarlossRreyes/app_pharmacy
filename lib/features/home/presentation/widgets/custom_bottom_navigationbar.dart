import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  void onItemTapped( BuildContext context, int index ) {
    switch(index) {
      case 0:
        context.go('/home/0');
        print("SE EJECUTA EL 0");       
        break;
      
      case 1:
        context.go('/home/1');
        print("SE EJECUTA EL 1");       
        break;

      case 2:
        context.go('/home/2');
        print("SE EJECUTA EL 2");       
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon( Icons.home),
          label: "Home",        
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.category),
          label: "Category"
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.shopping_cart),
          label: "Order"
        ),
      ],
    );
  }
}