import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_lock/components/continue_button.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/screen/task_detail/components/build_info.dart';

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

  @override
  Widget build(BuildContext context) {
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
              buildInfo(context, "Rewards:", rewards.toString()),
              buildInfo(context, "Assigned by", assigned),
              if (description != null)
                (Text(
                  "Description:",
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
              if (description != null)
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
                                    () {}));
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
                                    "Do you want this task to be mark as complete?.",
                                    () {}));
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
        ElevatedButton(onPressed: press, child: Text("Yes")),
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text("No")),
      ],
    );
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
              SizedBox(width: SizeConfig.screenWidth * 0.05),
              Text(
                value,
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
