import 'package:flutter/material.dart';
import 'package:task_lock/screen/add_task/components/body.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);
  static String routeName = "/add_task";

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Create a Task"),
        ),
        body: Body(),
      );
}
