import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:registro_conducta_app_v2/src/pages/psychologist/get_date_user.dart';
import 'package:registro_conducta_app_v2/src/services/ReportPDF/report_basico.dart';
import 'package:registro_conducta_app_v2/src/services/wiew_info/wiew_info_pensamiento.dart';

class PaginaListado extends StatelessWidget {
  const PaginaListado({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [contenedor(context)],
    );
  }

  Widget contenedor(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.00),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 69, 169, 252),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        height: 350.0,
        child: Column(children: <Widget>[
          const Text(
            "Listado de pacientes",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Expanded(
            child: contenido(context),
          )
        ]
            //aqui van los datos
            ));
  }
}

Widget contenido(BuildContext context) {
  Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where("role", isEqualTo: "paciente")
        .get();
    return querySnapshot.docs;
  }

  return FutureBuilder(
      future: getData(),
      builder: (_, snapshot) {
        return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (_, index) {
              DocumentSnapshot data = snapshot.data[index];
              return ListTile(
                  title: Text(
                    data['nombre'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  trailing: SizedBox(
                      width: 100,
                      child: Row(children: [
                        IconButton(
                            onPressed: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => getDates_user(
                                      data['nombre'], data['uid']),
                                ),
                              );
                            }),
                            icon: const Icon(Icons.remove_red_eye)),
                      ])));
            });
      });
}
