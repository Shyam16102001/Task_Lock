import 'package:firebase_auth/firebase_auth.dart';

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      user.reload();
      return user;
    } else {
      return user;
    }
  } catch (e) {
    return null;
  }
}
