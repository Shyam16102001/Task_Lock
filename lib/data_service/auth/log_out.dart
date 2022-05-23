import 'package:firebase_auth/firebase_auth.dart';

Future logOut() async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut();
  } catch (e) {}
}
