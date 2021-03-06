// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_lock/components/continue_button.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/data_service/get_event_list.dart';
import 'package:task_lock/screen/home_page/home_page.dart';

class TaskDetailScreen extends StatelessWidget {
  TaskDetailScreen({
    Key? key,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.description,
    required this.rewards,
    required this.assigned,
    required this.id,
  }) : super(key: key);
  static String routeName = "/task_detail";

  String name;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  String? description;
  int rewards;
  String assigned;
  String id;

  @override
  Widget build(BuildContext context) {
    int coins = 0;
    DateTime temp = DateFormat("MMM d, y h:mm a").parse("$endDate $endTime");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: kSecondaryColor,
      ),
      body: Container(
        color: kSecondaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              buildInfo(context, "Started from:", "$startDate, $startTime"),
              buildInfo(context, "Ending at:", "$endDate, $endTime"),
              buildInfo(context, "Remaining:", Jiffy(temp).fromNow()),
              buildInfo(context, "Rewards:", "$rewards"),
              buildInfo(context, "Assigned by:", assigned),
              if (description != "")
                (Text(
                  "Description:",
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
              if (description != "")
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: (Text(
                    description!,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .merge(const TextStyle(color: kBackgroundColor)),
                  )),
                ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 180,
                      child: ContinueButton(
                          color: Colors.red,
                          icon: Icons.cancel,
                          text: "Remove",
                          press: () {
                            showDialog(
                                context: context,
                                builder: (_) => alertDialog(
                                        context,
                                        "Remove this Task?",
                                        "This task will be removed from your profile.",
                                        () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Updating...")));
                                      Navigator.pop(context);
                                      FirebaseFirestore.instance
                                          .collection("Tasks")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .collection("Events")
                                          .doc(id)
                                          .delete()
                                          .then((value) => Navigator.popUntil(
                                              context,
                                              ModalRoute.withName(
                                                  HomePage.routeName)));
                                    }));
                          })),
                  SizedBox(
                      width: 180,
                      child: ContinueButton(
                          color: Colors.green,
                          icon: Icons.done,
                          text: "Completed",
                          press: () {
                            showDialog(
                                context: context,
                                builder: (_) => alertDialog(
                                        context,
                                        "Mark as complete?",
                                        "Do you want this task to be mark as complete?",
                                        () async {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Updating...")));
                                      Navigator.pop(context);
                                      coins = await DataBaseManager().getCoins(
                                          FirebaseAuth
                                              .instance.currentUser!.email);

                                      FirebaseFirestore.instance
                                          .collection("Tasks")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .collection("Events")
                                          .doc(id)
                                          .update({"Completed": true});

                                      if (assigned != "Yourself") {
                                        int coin = await DataBaseManager()
                                            .getCoins(assigned);
                                        FirebaseFirestore.instance
                                            .collection('Tasks')
                                            .doc(assigned)
                                            .set({"Coins": coin - rewards});
                                      }

                                      FirebaseFirestore.instance
                                          .collection('Tasks')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .set({"Coins": coins + rewards}).then(
                                              (value) => Navigator.popUntil(
                                                  context,
                                                  ModalRoute.withName(
                                                      HomePage.routeName)));
                                    }));
                          })),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * .1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget alertDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback press,
  ) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(onPressed: press, child: const Text("Yes")),
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: const Text("No")),
      ],
    );
  }

  String shortner(String text) {
    print(text.length);
    if (text.length > 22) {
      text = text.substring(0, 15);
      return ("$text.....");
    } else {
      return text;
    }
  }

  Widget buildInfo(BuildContext context, String title, String value) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(width: SizeConfig.screenWidth * 0.04),
              Text(
                shortner(value),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .merge(const TextStyle(color: kBackgroundColor)),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(7)),
        ],
      );
}
