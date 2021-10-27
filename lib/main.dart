import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login/login_authentication.dart';
import 'login/login_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context)=>LoginState(),
    builder: (context,_) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Consumer<LoginState>(
            builder: (context, loginState, child){
              return AuthenticationWidget(
                  loginState: loginState.loginState,
                  email: loginState.email,
                  startLoginFlow: loginState.startLoginFlow,
                  verifyEmail: loginState.verifyEmail,
                  signInWithEmailAndPassword: loginState.signInWithEmailAndPassword,
                  cancelRegistration: loginState.cancelRegistration,
                  registerAccount: loginState.registerAccount,
                  signOut: loginState.signOut
              );
            }
        ),
      ),
    );
  }
}


