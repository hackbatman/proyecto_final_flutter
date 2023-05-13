import 'package:flutter/material.dart';
import 'package:registro_conducta_app_v2/src/pages/patients/mod_reg_animo.dart';
import 'package:registro_conducta_app_v2/src/pages/patients/mod_reg_basico.dart';
import 'package:registro_conducta_app_v2/src/pages/patients/mod_reg_pensamientos.dart';
import 'package:registro_conducta_app_v2/src/pages/patients/mod_reg_rumia.dart';

class ModRegistro extends StatelessWidget {
  const ModRegistro({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(30.0),
      children: <Widget>[
        Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(10.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            // height: 350.0,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => registro_rumia()));
              },
              title: const Text(
                "Registro Rumia",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              subtitle: const Text(
                "Registro que se efectua una sola vez",
                style: TextStyle(
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
              trailing: const Icon(
                Icons.add_box_sharp,
                color: Colors.black54,
              ),
            )),
        Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(10.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            // height: 350.0,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FormRegAnimo()));
              },
              title: const Text(
                "Registro de actividades",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              subtitle: const Text(
                "Registro de actividades que realiza a diario",
                style: TextStyle(
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
              trailing: const Icon(
                Icons.add_box_sharp,
                color: Colors.black54,
              ),
            )),
        Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(10.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            // height: 350.0,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FormRegoPensamiento()));
              },
              title: const Text(
                "Registro de Ansiedad/Malestar",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              subtitle: const Text(
                "Registro de pensamientos, emociones, situaciones y conducta",
                style: TextStyle(
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
              trailing: const Icon(
                Icons.add_box_sharp,
                color: Colors.black54,
              ),
            )),
        Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.00),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 69, 169, 252),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          // height: 350.0,
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FormRegAnsiedad()));
            },
            title: const Text(
              "Registro Basico",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            subtitle: const Text(
              "Registros basicos hasta con cuestiones ambientales",
              style: TextStyle(
                  color: Colors.white24,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
            trailing: const Icon(
              Icons.add_box_sharp,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
