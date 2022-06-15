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
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          itemsList.add(querySnapshot.docs[i].data());
          itemsList[i]['ID'] = querySnapshot.docs[i].id;
        }
      });
      return itemsList;
    } catch (e) {
      return null;
    }
  }

  Future<int> getCoins(user) async {
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection('Tasks').doc(user).get();
    return variable["Coins"];
  }
}
