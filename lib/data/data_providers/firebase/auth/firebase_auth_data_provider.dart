import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthDataProvider {
  static final FirebaseAuthDataProvider _singleton = FirebaseAuthDataProvider
      ._internal();

  factory FirebaseAuthDataProvider(){
    return _singleton;
  }

  FirebaseAuthDataProvider._internal();

  Future<UserCredential> signIn(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  Stream<User?>authStateStream(){
    return FirebaseAuth.instance.authStateChanges();
  }


}
