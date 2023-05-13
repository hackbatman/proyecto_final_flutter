import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class registro_rumia extends StatelessWidget {
  const registro_rumia({Key? key}) : super(key: key);
  //user = FirebaseAuth.instance.currentUser!;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Registros Rumia"),
          backgroundColor: const Color.fromARGB(255, 9, 54, 70)),
      body: cuerpo(context),
      backgroundColor: const Color.fromARGB(255, 21, 31, 43),
    );
  }

  ListView cuerpo(BuildContext context) {
    DateTime nowtime = DateTime.now();
    TextEditingController txt_inicio_rumia = TextEditingController();
    TextEditingController txt_temas = TextEditingController();
    TextEditingController txtmalestar_activacion = TextEditingController();
    TextEditingController txtconducta = TextEditingController();
    TextEditingController txtfisica = TextEditingController();
    final user = FirebaseAuth.instance.currentUser!;
    final firebase = FirebaseFirestore.instance;

    registroPensamientos() async {
      try {
        await firebase.collection("registros_rumia").doc().set({
          "userUID": user.uid,
          "hora_registro": nowtime,
          "inicio_rumia": txt_inicio_rumia.text,
          "malestar_activacion": txtmalestar_activacion.text,
          "temas": txt_temas.text,
          "tip_register": "Registro Rumia"
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
                  "Liste aquí los inicios de sus rumias, por ejemplo “y si”, “pero”, “siempre”",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: null,
                controller: txt_inicio_rumia,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Ingrese sus rumias',
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
                  "Registrar aquí las frases que te generan malestar y activación",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: null,
                controller: txtmalestar_activacion,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Ingrese malestar y activacion',
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
                  "Registre aquí los temas sobre los que suele rumiar ",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 2,
                controller: txt_temas,
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
          /* Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            // height: 350.0,
            child: Column(children: <Widget>[
              Table(
                border: TableBorder.all(),
                children: [
                  TableRow(children: [Text("Respuesta"), Text("Selecciona")])
                ],
              )
            ]),
          ),*/
          Container(
            // margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
            child: ElevatedButton(
                onPressed: () async {
                  registroPensamientos();
                  Navigator.pop(context);
                },
                child: const Text("Guardar")),
          ),
        ]);
  }
}
