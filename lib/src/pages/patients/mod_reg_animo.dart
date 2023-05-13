import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class FormRegAnimo extends StatefulWidget {
  const FormRegAnimo({Key? key}) : super(key: key);

  @override
  _FormAnimo createState() => _FormAnimo();
}

class _FormAnimo extends State<FormRegAnimo> {
  _FormAnimo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Registro de estado de animo"),
          backgroundColor: const Color.fromARGB(255, 9, 54, 70)),
      body: cuerpo(),
      backgroundColor: const Color.fromARGB(255, 21, 31, 43),
    );
  }

  ListView cuerpo() {
    final controller = TextEditingController();

    TextEditingController actividad = TextEditingController();
    TextEditingController seleccion = TextEditingController();
    TextEditingController estado_ani = TextEditingController();
    TextEditingController trap_trac = TextEditingController();
    TextEditingController txtpregunta = TextEditingController();
    DateTime nowtime = DateTime.now();
    final user = FirebaseAuth.instance.currentUser!;
    final firebase = FirebaseFirestore.instance;
    registroAnimo() async {
      try {
        await firebase.collection("registros_estado_animo").doc().set({
          "userUID": user.uid,
          "hora_registro": nowtime,
          "Actividad": actividad.text,
          "estado_animo": estado_ani.text,
          "select_dom": seleccion.text,
          "trap_trac": trap_trac.text,
          "tip_register": "Registro de Estado de animo"
        });
      } catch (e) {
        print('Error in the database' + e.toString());
      }
    }

    return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            // height: 350.0,
            child: Column(children: <Widget>[
              const ListTile(
                title: Text(
                  "Actividades",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                subtitle: Text(
                  "Liste las actividades que hizo durante el dia",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 2,
                controller: actividad,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Ingrese actividades',
                ),
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            // height: 350.0,
            child: Column(children: <Widget>[
              const ListTile(
                title: Text(
                  "Estadp de Animo",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                subtitle: Text(
                  "del 1 al 10",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 2,
                controller: estado_ani,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Ingrese texto',
                ),
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            // height: 350.0,
            child: Column(children: <Widget>[
              const ListTile(
                title: Text(
                  "Disfrute, Dominio o valioso",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                subtitle: Text(
                  "Cual de las tres opciones",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 2,
                controller: seleccion,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Ingrese texto',
                ),
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            // height: 350.0,
            child: Column(children: <Widget>[
              const ListTile(
                title: Text(
                  "Trap o Trac",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                subtitle: Text(
                  "Seleccione cual opcion",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 2,
                controller: trap_trac,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Ingrese texto',
                ),
              ),
            ]),
          ),
          Container(
            // margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
            child: ElevatedButton(
              onPressed: () async {
                registroAnimo();
                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
          ),
        ]);
  }
}
