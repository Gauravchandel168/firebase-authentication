part of 'google_login_cubit.dart';

@immutable
abstract class GoogleLoginState {}

class GoogleLoginInitial extends GoogleLoginState {}

class GoogleLoginLoading extends GoogleLoginState {}

class GoogleLoginSuccess extends GoogleLoginState {}

class GoogleLoginError extends GoogleLoginState {
  String message;
  GoogleLoginError(this.message);
}

