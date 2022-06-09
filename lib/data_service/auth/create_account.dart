import 'package:firebase_auth/firebase_auth.dart';

Future<User?> createAccount(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    User? user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      return user;
    } else {
      return user;
    }
  } catch (e) {
    return null;
  }
}
