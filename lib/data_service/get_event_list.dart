import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseManager {
  Future getEventsList() async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection("Tasks")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("Events")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      return null;
    }
  }
}
