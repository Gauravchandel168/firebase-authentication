import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../logic/auth/auth_cubit.dart';
import '../../presentation/router/app_router.dart';
import '../../presentation/router/app_routes_utills.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: "All Screen",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
        builder: (context, child){
          child = BlocListener<AuthCubit, User?>(
            listener: (context, user) {
              if(user != null){
                navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRouter.button,(_)=>false);
              }else{
                navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRouter.login,(_)=>false);
              }
            },
            child: child,
          );
          return EasyLoading.init()(context,child);
        }
      
      

    );
  }
}
