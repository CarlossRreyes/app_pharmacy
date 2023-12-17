
import 'package:app_pharmacy/features/home/presentation/screen/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/provider.dart';
import '../../features/auth/auth.dart';
// import '../../features/category/category.dart';
import '../config.dart';


final goRouterProvider = Provider((ref){
  final goRouterProvider = ref.read( goRouterNotifierProvider );
  return GoRouter(
    initialLocation: "/splash",
    refreshListenable: goRouterProvider,
    routes: [
      GoRoute(
        path: "/splash",
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterScreen(),
      ),
      // GoRoute(
      //   path: "/",
      //   builder: (context, state) => const CategoriesScreen(),
      // ),

      //TODO: Home screen
      GoRoute(
        path: "/home/:page",
        name: HomeScreen.name,
        builder: (context, state) => HomeScreen(
          pageIndex: int.parse(state.pathParameters["page"].toString()),
          // pageIndex: 1,
        ),
      )
      //   // routes: [
      //   //   GoRoute(
      //   //     path: "path"
      //   //   )
      //   // ]
      // ),
    ],
    

    //TODO: BLOQUEAR SI NO ESTA AUTENTICADO
    redirect: (context, state) {
      final isGoingTo = state.fullPath;

      final authStatus = goRouterProvider.authStatus;

      if ( isGoingTo == "/splash" && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.noAuthenticated ){
        if ( isGoingTo == "/login" || isGoingTo == "/register" ) return null;
        return "/login";
      }

      if ( authStatus == AuthStatus.authenticated ){
        if ( isGoingTo == "/login" || isGoingTo == "/register" || isGoingTo == "/splash" ) return "/home/0";
        // if ( isGoingTo == "/login" || isGoingTo == "/register" || isGoingTo == "/splash" ) return "/";
      }

      return null;
    },
  );
});