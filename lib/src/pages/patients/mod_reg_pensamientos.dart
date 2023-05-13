import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormRegoPensamiento extends StatelessWidget {
  const FormRegoPensamiento({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Registro de pensamientos"),
          backgroundColor: const Color.fromARGB(255, 9, 54, 70)),
      body: cuerpo(context),
      backgroundColor: const Color.fromARGB(255, 21, 31, 43),
    );
  }

  ListView cuerpo(BuildContext context) {
    DateTime nowtime = DateTime.now();
    TextEditingController txtsituacion = TextEditingController();
    TextEditingController txtemociones = TextEditingController();
    TextEditingController txtpensamiento = TextEditingController();
    TextEditingController txtconducta = TextEditingController();
    TextEditingController txtfisica = TextEditingController();
    final user = FirebaseAuth.instance.currentUser!;
    final firebase = FirebaseFirestore.instance;

    registroPensamientos() async {
      try {
        await firebase.collection("registros_pensamientos").doc().set({
          "userUID": user.uid,
          "hora_registro": nowtime,
          "Situacion": txtsituacion.text,
          "Pensamientos": txtpensamiento.text,
          "Emociones": txtemociones.text,
          "sensacion_fisica": txtfisica.text,
          "conducta_respuesta": txtconducta.text,
          "tip_register": "registro de pensamientos"
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
            // margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
            child: ElevatedButton(
                onPressed: () {
                  OpenDialog(context);
                },
                child: const Text("Ejemplo")),
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
                  "Situacion",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                subtitle: Text(
                  "Lugar, lo que hacia, pensaba o sentia, si habia gente, momento del dia, si vi algo antes, etc",
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
                controller: txtsituacion,
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
                  "Pensamiento",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                /* subtitle: Text(
                  "Lugar, lo que hacia, pensaba o sentia, si habia gente, momento del dia, si vi algo antes, etc",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),*/
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 2,
                controller: txtpensamiento,
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
                  "Emociones",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                subtitle: Text(
                  "Emociones e intencidades de la emocion del 1 al 10",
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
                controller: txtemociones,
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
                  "Sensaciones Fisicas",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                /* subtitle: Text(
                  "Lugar, lo que hacia, pensaba o sentia, si habia gente, momento del dia, si vi algo antes, etc",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),*/
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 2,
                controller: txtfisica,
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
                  "Conducta",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                /* subtitle: Text(
                  "Lugar, lo que hacia, pensaba o sentia, si habia gente, momento del dia, si vi algo antes, etc",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),*/
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 2,
                controller: txtconducta,
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
                  registroPensamientos();
                  Navigator.pop(context);
                },
                child: const Text("Guardar")),
          ),
        ]);
  }

  void OpenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hola goodmen'),
        content: const Text('Soy Pablo xd'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Salir"))
        ],
      ),
    );
  }
}
