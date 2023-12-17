import 'package:app_pharmacy/features/security/presentation/providers/user/user_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';

final userDetailsProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final userRepository = ref.watch( userRepositoryProvider );
  return UserNotifier(
    userRepository: userRepository,
  );
});

class UserNotifier extends StateNotifier<UserState> {
  final SecurityRepository userRepository;
  UserNotifier({
      required this.userRepository
  }): super( UserState()){
    loadUser();
  }

  Future<void> loadUser() async {

    try {
      final user = await userRepository.getUserAuthenticate();
      state = state.copyWith(
        isLoading: false,
        user: user
      );
      
    } catch (e) {
      print(e);
    }

  }
  
}

class UserState {
  final bool? isLoading;
  final User? user;

  UserState({
    this.isLoading = true, 
    this.user
  });

  UserState copyWith({
    bool? isLoading,
    User? user,
  }) => UserState(
    isLoading: isLoading ?? this.isLoading,
    user: user ?? this.user
  );

}





/*
import 'package:app_pharmacy/features/security/presentation/providers/user/user_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';

final userDetailsProvider = StateNotifierProvider<UserMapNotifier, Map<String, User>>((ref) {
  final userRepository = ref.watch( userRepositoryProvider );
  return UserMapNotifier( getUser: userRepository.getUserAuthenticate );
});

typedef GetUsersCallback = Future<User> Function();

class UserMapNotifier extends StateNotifier<Map<String, User>> {

  final GetUsersCallback getUser;

  UserMapNotifier({
    required this.getUser
  }): super({}){
    loadUser();
  }

  Future<void> loadUser () async {
    final user = await getUser();
    state = {  ...state, user.idUser.toString() :user };
  }
  
}





*/
