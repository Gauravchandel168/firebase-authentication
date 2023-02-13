part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}


class LogoutSuccess extends LogoutState {}


class LogoutError extends LogoutState {
  String message;

  LogoutError(this.message);
}
