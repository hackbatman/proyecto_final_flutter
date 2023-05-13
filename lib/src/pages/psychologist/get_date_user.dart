import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:registro_conducta_app_v2/src/pages/psychologist/list_patients.dart';
import 'package:registro_conducta_app_v2/src/services/ReportPDF/report_animo.dart';
import 'package:registro_conducta_app_v2/src/services/ReportPDF/report_pensamiento.dart';
import 'package:registro_conducta_app_v2/src/services/ReportPDF/report_basico.dart';
import 'package:registro_conducta_app_v2/src/services/ReportPDF/report_rumia.dart';
import 'package:registro_conducta_app_v2/src/services/wiew_info/wiew_info_animo.dart';
import 'package:registro_conducta_app_v2/src/services/wiew_info/wiew_info_basico.dart';
import 'package:registro_conducta_app_v2/src/services/wiew_info/wiew_info_pensamiento.dart';
import 'package:registro_conducta_app_v2/src/services/wiew_info/wiew_info_rumia.dart';

class getDates_user extends StatelessWidget {
  final String datos;
  final String datos2;
  const getDates_user(this.datos, this.datos2, {super.key});
  // const getDates_user({Key? key}) : super(key: key);
  //user = FirebaseAuth.instance.currentUser!;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Registros de $datos'),
          backgroundColor: const Color.fromARGB(255, 9, 54, 70)),
      body: cuerpo(context),
      backgroundColor: const Color.fromARGB(255, 21, 31, 43),
    );
  }

  Widget cuerpo(BuildContext context) {
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
            "Listado de registros",
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

  Widget contenido(BuildContext context) {
    Future getData() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('registros_pensamientos')
          .where("userUID", isEqualTo: datos2)
          .orderBy('hora_registro', descending: true)
          .limit(1)
          .get();
      return querySnapshot.docs;
    }

    Future get_basico() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('registros_basico')
          .where("userUID", isEqualTo: datos2)
          .orderBy('hora_registro', descending: true)
          .limit(1)
          .get();
      return querySnapshot.docs;
    }

    Future get_animo() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('registros_estado_animo')
          .where("userUID", isEqualTo: datos2)
          .orderBy('hora_registro', descending: true)
          .limit(1)
          .get();
      return querySnapshot.docs;
    }

    Future get_rumia() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('registros_rumia')
          .where("userUID", isEqualTo: datos2)
          .orderBy('hora_registro', descending: true)
          .limit(1)
          .get();
      return querySnapshot.docs;
    }

    return Column(children: <Widget>[
      FutureBuilder(
          future: getData(),
          builder: (_, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  DocumentSnapshot data = snapshot.data[index];
                  return ListTile(
                      title: Text(
                        "Registro de Ansiedad y Malestar",
                        style: TextStyle(
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
                                      builder: (_) => info_pensamiento(
                                          datos, datos2, datos),
                                    ),
                                  );
                                }),
                                icon: const Icon(Icons.remove_red_eye)),
                            IconButton(
                                onPressed: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => report_pensamiento(
                                            docid: snapshot.data[index],
                                            nombre: datos)),
                                  );
                                }),
                                icon: const Icon(Icons.picture_as_pdf)),
                          ])));
                });
          }),
      FutureBuilder(
          future: get_basico(),
          builder: (_, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  DocumentSnapshot data = snapshot.data[index];
                  return ListTile(
                      title: Text(
                        "Registros Basico",
                        style: TextStyle(
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
                                      builder: (_) =>
                                          info_basico(datos, datos2, datos),
                                    ),
                                  );
                                }),
                                icon: const Icon(Icons.remove_red_eye)),
                            IconButton(
                                onPressed: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => report_basico(
                                            docid: snapshot.data[index],
                                            nombre: datos)),
                                  );
                                }),
                                icon: const Icon(Icons.picture_as_pdf)),
                          ])));
                });
          }),
      FutureBuilder(
          future: get_animo(),
          builder: (_, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  DocumentSnapshot data = snapshot.data[index];
                  return ListTile(
                      title: Text(
                        "Registros de Estado de Animo",
                        style: TextStyle(
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
                                      builder: (_) =>
                                          info_animo(datos, datos2, datos),
                                    ),
                                  );
                                }),
                                icon: const Icon(Icons.remove_red_eye)),
                            IconButton(
                                onPressed: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => report_animo(
                                            docid: snapshot.data[index],
                                            nombre: datos)),
                                  );
                                }),
                                icon: const Icon(Icons.picture_as_pdf)),
                          ])));
                });
          }),
      FutureBuilder(
          future: get_rumia(),
          builder: (_, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  DocumentSnapshot data = snapshot.data[index];
                  return ListTile(
                      title: Text(
                        "Registros de Rumia",
                        style: TextStyle(
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
                                      builder: (_) =>
                                          info_rumia(datos, datos2, datos),
                                    ),
                                  );
                                }),
                                icon: const Icon(Icons.remove_red_eye)),
                            IconButton(
                                onPressed: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => report_rumia(
                                            docid: snapshot.data[index],
                                            nombre: datos)),
                                  );
                                }),
                                icon: const Icon(Icons.picture_as_pdf)),
                          ])));
                });
          }),
    ]);
  }
}
