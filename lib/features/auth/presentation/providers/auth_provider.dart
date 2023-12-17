
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/shared.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';


final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository, 
    keyValueStorageService: keyValueStorageService,
    
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,

  }): super(AuthState()){
    checkAuthStatus();
  }

  Future<void> loginUser( String email, String password ) async{

    try {
      
      final authUser  = await authRepository.login(email, password);
      
      _setLoggedUser(authUser.token);
    } on CustomError catch (e) {
      // print(e.message);
      logout( e.message );
    } catch (e) {
      logout( 'Error no contralado' );
    }
  }

  //TODO: _setLoggedUser => cambiar el token x AuthUser

  // void _setLoggedUser( AuthUser authUser ) async {
  //   await keyValueStorageService.setKeyValue("token", authUser.token );
  //   state = state.copyWith(
  //     authUser: authUser,
  //     authStatus: AuthStatus.authenticated,
  //     errorMessage: ""
  //   );
  // }

  void _setLoggedUser( String token ) async {
    await keyValueStorageService.setKeyValue("token", token );
    state = state.copyWith(
      token: token,
      authStatus: AuthStatus.authenticated,
      errorMessage: ""
    );
  }

  Future<void> logout( [ String? errorMessage ]) async {    
    await keyValueStorageService.removeKey("token");

    state = state.copyWith(
      authStatus: AuthStatus.noAuthenticated,
      token: "",
      errorMessage: errorMessage
    );
  }
  // Future<void> logout( [ String? errorMessage ]) async {
  //   //TODO: Limpiar el token
  //   await keyValueStorageService.removeKey("token");

  //   state = state.copyWith(
  //     authStatus: AuthStatus.noAuthenticated,
  //     authUser: null,
  //     errorMessage: errorMessage
  //   );
  // }
  

  void checkAuthStatus( ) async{
    final token = await keyValueStorageService.getValue<String>("token");
    if( token == null ) return logout();

    try {
      final authUser = await authRepository.checkAuthStatus(token);
      if( authUser.status ){
        _setLoggedUser(token);        
      }
    } catch (e) {
      logout();
    }
  }
}

enum AuthStatus { checking, authenticated, noAuthenticated }
//TODO: CAMBIAMOS EL STATE
class AuthState {
  final AuthStatus authStatus;
  final String token;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.token = "", 
    this.errorMessage = ""
  });

  AuthState copyWith({

    AuthStatus? authStatus,
    String? token,
    String? errorMessage

  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    token: token ?? this.token,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  
}
/*
class AuthState {
  final AuthStatus authStatus;
  final AuthUser? authUser;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.authUser, 
    this.errorMessage = ""
  });

  AuthState copyWith({

    AuthStatus? authStatus,
    AuthUser? authUser,
    String? errorMessage

  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    authUser: authUser ?? this.authUser,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  
}
*/
