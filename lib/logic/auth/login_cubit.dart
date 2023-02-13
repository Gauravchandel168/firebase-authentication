import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository.dart';
import '../internet/internet_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  final InternetCubit internetCubit;
  LoginCubit(this.authRepository,this.internetCubit) : super(LoginInitial());


  signIn(String email, String password) async {
    final e = email.trim();
    final p = password.trim();
    if (e.isEmpty) {
      emit(LoginError("Email cannot be empty"));
    } else if (p.isEmpty) {
      emit(LoginError("Password cannot be empty"));
    } else if (p.length < 6) {
      emit(LoginError("Password length must be 6 or more than 6."));
    } else if (!internetCubit.state) {
      emit(LoginError("Internet is not available!."));
    }else {
      try {
        emit(LoginLoading());
        final userCredential = await authRepository.signIn(e, p);
        if (userCredential.user != null) {
          emit(Loginsuccess());
        } else {
          emit(LoginError("sign_in is failed.Please try again"));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          emit(LoginError("No usser found for that email. "));
        } else if (e.code == "wrong-password") {
          emit(LoginError("wrong password provided for tat user."));
        }
      }
    }
  }
}
