import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practise_functionality_screen/data/repositories/auth_repository.dart';


class AuthCubit extends Cubit<User?> {
  final AuthRepository authRepository;
  late final StreamSubscription _subscription;

  AuthCubit(this.authRepository) : super(null) {
    _subscription = authRepository.authStateStream().listen((user) {
      emit(user);
    });
  }


  @override
  close() {
    _subscription.cancel();
    return super.close();
  }
}