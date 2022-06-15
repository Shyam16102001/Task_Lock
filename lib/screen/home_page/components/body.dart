import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:task_lock/data_service/get_event_list.dart';
import 'package:task_lock/screen/task_detail/task_detail_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  List userTaskList = [];
  late Timer timer;

  @override
  void initState() {
    user = _auth.currentUser!;
    user.reload();
    if (user.displayName == null) {
      user.reload();
    }
    fetchDatabaseList();
    // timer = Timer.periodic(const Duration(seconds: 10), (timer) {
    //   fetchDatabaseList();
    // });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  fetchDatabaseList() async {
    print("x");
    dynamic result = await DataBaseManager().getEventsList();
    if (result == null) {
    } else {
      setState(() {
        userTaskList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // fetchDatabaseList();
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          welcomeMessage(context, user),
          SizedBox(height: getProportionateScreenHeight(15)),
          Text(
            "Your pending Tasks:",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .merge(const TextStyle(color: kTextColor)),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          userTaskList.isEmpty
              ? noTaskFound()
              : SizedBox(
                  height: 500,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        fetchDatabaseList();
                      });
                    },
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: userTaskList.length,
                        itemBuilder: (context, index) {
                          final completed = userTaskList[index]['Completed'];
                          final name = userTaskList[index]['Name'];
                          final startDate = userTaskList[index]['StartDate'];
                          final startTime = userTaskList[index]['StartTime'];
                          final endDate = userTaskList[index]['EndDate'];
                          final endTime = userTaskList[index]['EndTime'];
                          final rewards = userTaskList[index]['Rewards'];
                          final assigned = userTaskList[index]['AssignedBy'];
                          final description =
                              userTaskList[index]['Description'];
                          final id = userTaskList[index]['ID'];

                          return buildList(
                              context,
                              completed,
                              name,
                              startDate,
                              startTime,
                              endDate,
                              endTime,
                              rewards,
                              assigned,
                              description,
                              id,
                              index);
                        },
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget noTaskFound() {
    fetchDatabaseList();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: SvgPicture.asset(
        "assets/images/not_found.svg",
        height: getProportionateScreenHeight(500),
      ),
    );
  }
}

Widget buildList(
    BuildContext context,
    bool completed,
    String? name,
    String? startDate,
    String? startTime,
    String? endDate,
    String? endTime,
    double? rewards,
    String? assigned,
    String? description,
    String? id,
    int index) {
  return completed
      ? Container()
      : InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskDetailScreen(
                          name: name!,
                          assigned: assigned!,
                          endDate: endDate!,
                          endTime: endTime!,
                          rewards: rewards!.toInt(),
                          startDate: startDate!,
                          startTime: startTime!,
                          description: description,
                          id: id!,
                        )));
          },
          child: Container(
            margin: EdgeInsets.all(getProportionateScreenWidth(10)),
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black45, blurRadius: 3)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text("Rewards: ${rewards!.toInt()}"),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(3)),
                Text("$endDate - $endTime"),
              ],
            ),
          ),
        );
}

Widget welcomeMessage(BuildContext context, User user) {
  return SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello ${user.displayName ?? "User001"} !",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "Have a nice day.",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );
}
