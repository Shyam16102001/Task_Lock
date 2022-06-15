import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/data_service/get_event_list.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);
  static String routeName = "/rewards";

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        iconTheme: const IconThemeData(color: kBackgroundColor, size: 32),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: kSecondaryColor,
            height: getProportionateScreenHeight(150),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.monetization_on,
                      size: getProportionateScreenHeight(50),
                      color: Colors.amber,
                    ),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    Text(
                      coins.toString(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                Text(
                  "Coin Balance",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .merge(const TextStyle(color: kBackgroundColor)),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "Use the coins to redeem existing vouchers",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .merge(const TextStyle(color: kBackgroundColor)),
                )
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Text(
            " Redeem Vouchers: ",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 500,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 227,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (_, index) => loading(),
              itemCount: 8,
            ),
          ),
        ],
      ),
    );
  }

  Container loading() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      width: 200,
      height: 300,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Skeleton(
            height: 120,
            width: 120,
          ),
          const SizedBox(height: 10),
          const Skeleton(
            width: 180,
            height: 20,
          ),
          Divider(
            color: Colors.black.withOpacity(0.1),
            indent: 10,
            endIndent: 10,
            thickness: 1,
          ),
          const Skeleton(
            height: 10,
            width: 50,
          ),
          const SizedBox(height: 10),
          const Skeleton(
            height: 20,
            width: 80,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          // color: Colors.b,
          borderRadius: const BorderRadius.all(const Radius.circular(16))),
    );
  }
}
