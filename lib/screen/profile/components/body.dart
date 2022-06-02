import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_lock/config/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  @override
  void initState() {
    user = _auth.currentUser!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          Text("Name"),
        ],
      ),
    );
  }
}
// onPressed: (() => logOut().then((value) => {
//                       Navigator.of(context).pushNamedAndRemoveUntil(
//                           SignInScreen.routeName,
//                           (Route<dynamic> route) => false),
//                     })),