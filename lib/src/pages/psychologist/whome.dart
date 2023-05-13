import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

class PaginaHome extends StatelessWidget {
  const PaginaHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.00),
        child: Container(
            padding: const EdgeInsets.all(20.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            height: 550.0,
            child: Column(children: <Widget>[
              const Text(
                "pacientes Registrados recientemente",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: contenido(),
              ),
            ]
                //aqui van los datos

                )));
  }

  Widget contenido() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where("role", isEqualTo: "paciente")
            .snapshots(),
        builder: (_, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (_, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    {
                      var now = DateTime.now();
                      var tiempo = DateFormat('dd-MM-yyyy').format(now);

                      return ListTile(
                        onTap: () {},
                        title: Text(
                          data['nombre'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      );
                    }
                  });
        });
  }
}
