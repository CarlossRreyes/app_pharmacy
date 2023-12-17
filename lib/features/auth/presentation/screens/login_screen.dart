
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/widgets.dart';
import '../providers/provider.dart';

class LoginScreen extends StatelessWidget {
  
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        body: _LoginForm(),
      )
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackbar( BuildContext context, String message ){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text( message ))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginForm = ref.watch( loginFormProvider );

    ref.listen(authProvider, (previous, next) {      
      if( next.errorMessage.isEmpty ) return;
      showSnackbar(context, next.errorMessage );
    });

    return  Padding(
      padding: const EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: [
          const SizedBox( height: 50 ),
          const Text("Login"),
          const SizedBox( height: 90 ),

          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            // onChanged: (value) => ref.read( loginFormProvider.notifier ).onEmailChange(value),
            onChanged: ref.read( loginFormProvider.notifier ).onEmailChange,
            errorMessage: loginForm.isFormPosted
              ? loginForm.email.errorMessage
              : null,
          ),


          const SizedBox( height: 30 ),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read( loginFormProvider.notifier ).onPasswordChange,
            onFieldSubmitted: ( _ ) => ref.read( loginFormProvider.notifier ).onFormSubmit(),
            errorMessage: loginForm.isFormPosted
              ? loginForm.password.errorMessage
              : null,
          ),

          const SizedBox( height: 40,),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Iniciar sesión',
              buttonColor: Colors.black,
              onPressed: loginForm.isPosting 
                ? null
                : ref.read( loginFormProvider.notifier ).onFormSubmit,
            )
          ),
          
        ],
      ),
    );
  }
}