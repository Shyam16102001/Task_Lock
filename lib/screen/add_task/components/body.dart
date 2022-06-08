import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_lock/components/continue_button.dart';
import 'package:task_lock/config/constants.dart';
import 'package:task_lock/config/size_config.dart';
import 'package:intl/intl.dart';
import 'package:task_lock/data_service/get_event_list.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String description = "";
  double coins = 5;
  String? mail;
  bool self = true;
  List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              assignSelector(),
              if (!self) (emailFormField()),
              nameFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              dateSelector(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              timeSelector(),
              if (!self) (rewardsSelector()),
              descriptionFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              ContinueButton(
                  text: "Create Task",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection("Tasks")
                          .doc(self
                              ? FirebaseAuth.instance.currentUser!.email
                              : mail)
                          .collection("Events")
                          .doc()
                          .set({
                        "Name": name.toString(),
                        "StartDate":
                            DateFormat.yMMMd().format(startDate).toString(),
                        "EndDate":
                            DateFormat.yMMMd().format(endDate).toString(),
                        "StartTime": startTime.format(context).toString(),
                        "EndTime": endTime.format(context).toString(),
                        "Description": description,
                        "Rewards": self ? 5.0 : coins,
                        "AssignedBy": self
                            ? "Yourself"
                            : FirebaseAuth.instance.currentUser!.email,
                        "Completed": false
                      }).then((value) => Navigator.pop(context));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget assignSelector() {
    return Row(
      children: [
        Text(
          "Assign to ",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        DropdownButton<String>(
          value: self ? "Myself" : "Others",
          style: Theme.of(context).textTheme.headlineSmall,
          underline: Container(),
          onChanged: (String? newValue) {
            setState(() {
              self = newValue == "Others" ? false : true;
            });
          },
          items: <String>['Myself', 'Others']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget rewardsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.03),
        Text(
          "Rewards",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Slider(
          value: coins,
          onChanged: (newValue) {
            setState(() {
              coins = newValue;
            });
          },
          divisions: 10,
          label: "${coins.toInt()}",
          min: 0.0,
          max: 10.0,
        ),
      ],
    );
  }

  Widget timeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Start Time",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            GestureDetector(
              onTap: () async {
                TimeOfDay? newTime = await showTimePicker(
                    context: context, initialTime: startTime);
                if (newTime != null) {
                  setState(() {
                    startTime = newTime;
                  });
                }
              },
              child: Text(
                startTime.format(context),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "End Time",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            GestureDetector(
              onTap: () async {
                TimeOfDay? newTime = await showTimePicker(
                    context: context, initialTime: startTime);
                if (newTime != null) {
                  setState(() {
                    endTime = newTime;
                  });
                }
              },
              child: Text(
                endTime.format(context),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget dateSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Start Date",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            GestureDetector(
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2300));
                if (newDate != null) {
                  setState(() {
                    startDate = newDate;
                  });
                }
              },
              child: Text(
                DateFormat.yMMMd().format(startDate),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "End Date",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            GestureDetector(
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: startDate,
                    lastDate: DateTime(2300));
                if (newDate != null) {
                  setState(() {
                    endDate = newDate;
                  });
                }
              },
              child: Text(
                DateFormat.yMMMd().format(endDate),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }

  TextFormField emailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => setState(() {
        mail = newValue!;
      }),
      onChanged: (value) => setState(() {
        mail = value;
      }),
      validator: (mail) {
        if (mail == null || mail.isEmpty) {
          return "Please enter the email id person to whom you want to assign the task.";
        }
        return null;
      },
      style: const TextStyle(color: kTextColor, fontSize: 24),
      decoration: InputDecoration(
        labelText: "Participant Email ID",
        labelStyle: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  TextFormField nameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => setState(() {
        name = newValue!;
      }),
      onChanged: (value) => setState(() {
        name = value;
      }),
      validator: (name) {
        if (name == null || name.isEmpty) {
          return "Please enter the name of the task";
        }
        return null;
      },
      style: const TextStyle(color: kTextColor, fontSize: 24),
      decoration: InputDecoration(
        labelText: "Name",
        labelStyle: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  TextFormField descriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => setState(() {
        description = newValue!;
      }),
      onChanged: (value) => setState(() {
        description = value;
      }),
      maxLines: 3,
      style: const TextStyle(color: kTextColor, fontSize: 24),
      decoration: InputDecoration(
        labelText: "Description",
        labelStyle: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
