import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_lock/components/checking.dart';
import 'firebase_options.dart';
import 'package:task_lock/config/routes.dart';
import 'package:task_lock/config/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peca',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: Checking.routeName,
      routes: routes,
    );
  }
}
