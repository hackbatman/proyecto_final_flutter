import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro_conducta_app_v2/firebase_options.dart';
import 'package:registro_conducta_app_v2/src/pages/login/login.dart';
import 'package:registro_conducta_app_v2/src/pages/patients/pmain.dart';
import 'package:registro_conducta_app_v2/src/pages/psychologist/wmain.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Mymain());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Mymain extends StatelessWidget {
  const Mymain({Key? key}) : super(key: key);
//https://i.ibb.co/9tZL6SB/Logo-Mobil.png
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }

/*
Widget build(BuildContext context) {
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error de conexion'));
      } else if (snapshot.hasData) {
        return const ModMenu();
      } else {
        return const Login();
      }
    },
  );*/
}
