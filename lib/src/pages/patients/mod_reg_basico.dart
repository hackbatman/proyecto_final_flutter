import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormRegAnsiedad extends StatelessWidget {
  const FormRegAnsiedad({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Registro de Ansiedad o Malestar"),
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
    TextEditingController txtrespuesta = TextEditingController();
    TextEditingController txtpregunta = TextEditingController();
    final user = FirebaseAuth.instance.currentUser!;
    final firebase = FirebaseFirestore.instance;
    registroAnsiedad() async {
      try {
        await firebase.collection("registros_basico").doc().set({
          "userUID": user.uid,
          "hora_registro": nowtime,
          "Situacion": txtsituacion.text,
          "Pensamientos": txtpensamiento.text,
          "Emociones": txtemociones.text,
          "Respuestas": txtrespuesta.text,
          "cambio": txtpregunta.text,
          "tip_register": "Registro de Basico"
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
            padding: const EdgeInsets.all(10),
            child: const Text(
                "Instrucciones: Rellena cada columna con el elemento correspondiente. En la parte de “situación” puedes incluir tanto cuestiones ambientales y de conducta como de pensamientos, emociones o sensaciones físicas si notas que estos sucedieron al inicio “de la cadena”. Usualmente la parte de “situación” nos ayuda a notar el “disparador”, es decir, aquel suceso que desencadeno el resto de las reacciones. Si no logras discernirlo, no te preocupes y solo apunta lo que logres identificar.   ",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
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
                subtitle: Text(
                  "Durante el malestar",
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
                  "Respuestas",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                subtitle: Text(
                  "Que hice tras sentir el malestar?",
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
                controller: txtrespuesta,
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
                  "Qué cambio o que lograste? ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                subtitle: Text(
                  "¿La emocion bajo, alguien modifico su comportamiento, etc?",
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
                controller: txtpregunta,
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
                registroAnsiedad();
                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
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

/*
  Future createDate({required String datos}) async {
    final docDates = FirebaseFirestore.instance.collection('registros').doc();
    final datesP = Datesp(
      id: docDates.id,
      datos: datos,
    );
    final json = datesP.toJson();
    await docDates.set(json);

    class Datesp {
  String id;
  final String datos;
  Datesp({
    this.id = '',
    required this.datos,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'datos': datos,
      };

}

  }*/

}
