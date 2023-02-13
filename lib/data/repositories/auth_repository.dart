import 'package:firebase_auth/firebase_auth.dart';
import 'package:practise_functionality_screen/data/data_providers/firebase/auth/firebase_auth_data_provider.dart';

class  AuthRepository{
  Future<UserCredential>signIn(String email, String password){
  return FirebaseAuthDataProvider().signIn(email, password);
}
  Future<UserCredential>signInWithGoogle(){
    return FirebaseAuthDataProvider().signInWithGoogle();
}

Stream<User?>authStateStream(){
    return FirebaseAuthDataProvider().authStateStream();
}


signOut()async{
    return FirebaseAuthDataProvider().signOut();
}

}