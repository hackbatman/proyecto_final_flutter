import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registro_conducta_app_v2/src/pages/login/login.dart';
import 'package:registro_conducta_app_v2/src/pages/patients/tipos_registros.dart';

import 'package:registro_conducta_app_v2/src/pages/patients/phome.dart';
import 'package:registro_conducta_app_v2/src/services/userProfile.dart';

class ModMenu extends StatelessWidget {
  const ModMenu({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aplicacion de registro de Conducta",
      home: Inicio(),
    );
  }
} //https://i.ibb.co/9tZL6SB/Logo-Mobil.png

class Inicio extends StatefulWidget {
  Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int pagActual = 0;
  List<Widget> Paginas_ = [
    const ModHome(),
    const ModRegistro(),
    const UserProfile()
  ];
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registros de conducta"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 9, 54, 70),
      ),
      body: Paginas_[pagActual],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color.fromARGB(255, 2, 63, 84),
        onTap: (index) {
          setState(() {
            pagActual = index;
          });
        },
        currentIndex: pagActual,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "home",
              backgroundColor: Color.fromARGB(255, 2, 63, 84)),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
            ),
            label: "Registros",
            backgroundColor: Color.fromARGB(255, 2, 63, 84),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "configuracion",
              backgroundColor: Color.fromARGB(255, 2, 63, 84))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 21, 31, 43),
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }
}
