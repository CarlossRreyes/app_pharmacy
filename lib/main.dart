import 'package:app_pharmacy/config/constans/environment.dart';
import 'package:app_pharmacy/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Environment.initEnvironment();
  runApp(
    const ProviderScope( child: MainApp() )
  );

}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build( BuildContext context, WidgetRef ref ) {
    final appRouter = ref.watch( goRouterProvider );
    return MaterialApp.router(
      routerConfig: appRouter,
    );
  }
}
