import 'package:firebase_auth/firebase_auth.dart';

Future logOut() async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    await auth.signOut();
  } catch (e) {}
}
