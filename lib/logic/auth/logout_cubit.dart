import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepository authRepository;
  LogoutCubit(this.authRepository) : super(LogoutInitial());

  signOut() async {
    try{
      emit(LogoutLoading());
      await authRepository.signOut();
      emit(LogoutSuccess());
    }catch(e){
      emit(LogoutError("Something went wrong."));
    }

  }




}
