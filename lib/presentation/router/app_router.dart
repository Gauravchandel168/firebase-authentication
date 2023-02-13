import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_functionality_screen/data/repositories/auth_repository.dart';
import 'package:practise_functionality_screen/logic/auth/login_cubit.dart';
import 'package:practise_functionality_screen/logic/internet/internet_cubit.dart';
import 'package:practise_functionality_screen/presentation/screen/firestore_page/firestore_page.dart';

import '../../core/exception/route_exception.dart';
import '../../logic/auth/google_login_cubit.dart';
import '../../logic/auth/logout_cubit.dart';
import '../screen/button/button_page.dart';
import '../screen/login/login_page.dart';
import '../screen/splash/splash_page.dart';
import '../screen/user_screen/user_page.dart';

class AppRouter {
  static const String home = '/';
  static const String login = "/login";
  static const String button = "/button";
  static const String firestore = "/firestore";
  static const String user = "/user";
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _splashMaterialPageRoute();
      case login:
        return _loginMaterialPageRoute();
      case button:
        return _buttonMaterialPageRoute();

      case firestore:
        return _firestoreMaterialPageRoute();

      case user:
        return _userMaterialPageRoute();


      default:
        throw const RouteException('Route not found!');
    }
  }

  static _splashMaterialPageRoute() =>
      MaterialPageRoute(builder: (_) => const SplashPage());

  static _loginMaterialPageRoute() =>
      MaterialPageRoute(
        builder: (_) =>
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      LoginCubit(context.read<AuthRepository>(),context.read<InternetCubit>()),
                ),
                BlocProvider(
                  create: (context) =>
                      GoogleLoginCubit(context.read<AuthRepository>()),
                ),
              ],
              child: LoginPage(),
            ),

      );


  static _buttonMaterialPageRoute() =>
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider(
              create: (context) => LogoutCubit(context.read<AuthRepository>()),
              child: ButtonPage(),
            ),
      );


  static _firestoreMaterialPageRoute() => MaterialPageRoute(
      builder: (_) => FirestorePage());


  static _userMaterialPageRoute() => MaterialPageRoute(
      builder: (_) => UserPageState());
}