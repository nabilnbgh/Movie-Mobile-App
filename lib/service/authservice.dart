import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return auth.authStateChanges();
  }

  void initAuth() async{
    auth.authStateChanges();
  }

  Future signInAnonymosly() async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        throw Exception("User is null");
      }
    } catch (e) {
      Logger().e("Something went wrong", error: e);
      return null;
    }
  }

  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        throw Exception("User is null");
      }
    } catch (e) {
      Logger().e("Something went wrong", error: e);
      return null;
    }
  }

  Future signUpEmailPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        throw Exception("Register failed, User is Null");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      Logger().e("Something went wrong", error: e);
      return null;
    }
  }
}
