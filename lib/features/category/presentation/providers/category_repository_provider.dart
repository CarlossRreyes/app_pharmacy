

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/provider.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {

  // final accessToken = ref.watch( authProvider ).authUser?.token ?? "";
  final accessToken = ref.watch( authProvider ).token;
  final categoryRepository = CategoryRepositoryImpl(
    CategoryDataSourceImpl(accessToken: accessToken)
  );
  
  return categoryRepository;
});