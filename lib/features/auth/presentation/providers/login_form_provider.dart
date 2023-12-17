



import 'package:app_pharmacy/features/auth/presentation/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import '../../../shared/infrastructure/inputs/inputs.dart';

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isFormPosted = false,
    this.isPosting = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure()
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  @override
  String toString() {
    return '''
      LoginFormState: 
        isFormPosted: $isFormPosted
        isPosting: $isPosting
        isValid: $isValid
        email: $email
        password: $password
    ''';
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final Function ( String, String ) loginUserCallback;

  LoginFormNotifier({
    required this.loginUserCallback
  }): super(
    LoginFormState()
  );

  onEmailChange( String value ){
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([ newEmail, state.email ])
    );
  }

  onPasswordChange( String value ){
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.password ])
    );
  }

  _touchEveryField(){
    final email = Email.dirty( state.email.value );
    final password = Password.dirty( state.password.value );

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([ email, password ])
    );
  }

  onFormSubmit() async {
    _touchEveryField();    
    if( !state.isValid ) return;

    state = state.copyWith(
      isPosting: true
    );
    // print("State: $state");
    await loginUserCallback( state.email.value, state.password.value );
    state = state.copyWith(
      isPosting: false
    );
  } 
}


final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch( authProvider.notifier ).loginUser;
  
  return LoginFormNotifier(loginUserCallback: loginUserCallback);
});

