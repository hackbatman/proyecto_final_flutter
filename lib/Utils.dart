import 'package:flutter/material.dart';

class Utils {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static ShowSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    var messegerKey;
    messegerKey.currentState!
      ..RemoveCurrentSnackbar()
      ..ShowSnackBar(snackBar);
  }
}


/*
FutureBuilder(
        future: collectionReference.get(),
        builder: (context, snapshot) {
           if (snapshot.hasData) {
             List myDocCount = snapshot.data.docs;
             var totalStudent = myDocCount.length.toString();
             return Text(totalStudent.toString());
           } else {
             return Center(child: CircularProgressIndicator());
           }
        },
      );     */
