import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_lock/components/continue_button.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/data_service/auth/log_out.dart';
import 'package:task_lock/data_service/get_event_list.dart';
import 'package:task_lock/screen/rewards/rewards_screen.dart';
import 'package:task_lock/screen/sign_in/sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int coins = 0;
  @override
  void initState() {
    fetchcoins();
    super.initState();
  }

  fetchcoins() {
    DataBaseManager()
        .getCoins(FirebaseAuth.instance.currentUser!.email)
        .then((value) {
      setState(() {
        coins = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(24)),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Center(
              child: user.photoURL == null
                  ? SvgPicture.asset(
                      "assets/images/profile.svg",
                      height: 200,
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.photoURL!,
                      ),
                      radius: 100,
                    ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            buildInfo("Name :", user.displayName ?? "Unkown User 001"),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            buildInfo("Email ID :", user.email ?? "Mail ID"),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            buildInfo("Coins :", coins.toString()),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            ContinueButton(
                color: Colors.orange,
                text: "Rewards Section",
                press: () =>
                    Navigator.pushNamed(context, RewardsScreen.routeName)),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            ContinueButton(
              text: "Log Out",
              press: () => logOut().then((value) => {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        SignInScreen.routeName,
                        (Route<dynamic> route) => false),
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(String title, String value) => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: getProportionateScreenWidth(24),
                  color: kPrimaryColor),
            ),
            SizedBox(width: SizeConfig.screenHeight * 0.05),
            Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "Poppins",
                  fontSize: getProportionateScreenWidth(20),
                  color: kSecondaryColor),
            ),
          ],
        ),
      );
}
