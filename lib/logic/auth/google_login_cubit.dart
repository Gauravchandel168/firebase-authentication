import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository.dart';

part 'google_login_state.dart';

class GoogleLoginCubit extends Cubit<GoogleLoginState> {
  final AuthRepository authRepository;

  GoogleLoginCubit(this.authRepository) : super(GoogleLoginInitial());

  signIn() async {
 try{
   emit(GoogleLoginLoading());
   final userCredential= await authRepository.signInWithGoogle();
   if(userCredential.user !=null){
     emit(GoogleLoginSuccess());
   }else{
     emit(GoogleLoginError("sign-in is failed. Please try again. "));
   }
 }catch(e){
   emit(GoogleLoginError("Something went wrong."));
 }



  }
}
