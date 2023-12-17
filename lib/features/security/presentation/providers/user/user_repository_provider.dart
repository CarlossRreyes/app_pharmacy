import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../auth/presentation/providers/provider.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final userRepositoryProvider = Provider<SecurityRepository>((ref) {
  final accessToken = ref.watch( authProvider ).token;
  final securityRepository = SecurityRepositoryImpl(
    SecurityDataSourceImpl( accessToken: accessToken )
  );
  return securityRepository;
});