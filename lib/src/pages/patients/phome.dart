import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registro_conducta_app_v2/src/services/sevices_data.dart';
import 'package:registro_conducta_app_v2/src/services/wiew_info/wiew_info_pensamiento.dart';

class ModHome extends StatelessWidget {
  const ModHome({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.00),
        child: Container(
            padding: const EdgeInsets.all(20.00),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 69, 169, 252),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            height: 450.0,
            child: Column(children: <Widget>[
              const Text(
                "Registros anteriores",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Container(
                child: contenido(context),
              ),
            ])));
  }

  Widget contenido(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final String idUsuario = user.uid;
    var now = DateTime.now();
    var tiempo = DateFormat('dd-MM-yyyy').format(now);

    return Column(children: <Widget>[
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('registros_pensamientos')
              .where("userUID", isEqualTo: idUsuario)
              .orderBy('hora_registro', descending: true)
              .limit(1)
              .snapshots(),
          builder: (_, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (_, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      {
                        return ListTile(
                          onTap: () {},
                          title: Text(
                            data['tip_register'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          subtitle: Text(
                            formatTime(data['hora_registro']),
                            style: const TextStyle(
                                color: Colors.white24,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          trailing: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Color.fromARGB(137, 253, 250, 250),
                          ),
                        );
                      }
                    });
          }),
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('registros_pensamientos')
              .where("userUID", isEqualTo: idUsuario)
              .orderBy('hora_registro', descending: true)
              .limit(1)
              .snapshots(),
          builder: (_, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (_, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      {
                        var tiempo_date = formatTiempo(data['hora_registro']);

                        if ((tiempo != tiempo_date)) {
                          return Center(
                            child: Text('No hay registro hoy'),
                          );
                        } else {
                          return ListTile(
                            onTap: () {},
                            title: Text(
                              data['tip_register'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            subtitle: Text(
                              formatTime(data['hora_registro']),
                              style: const TextStyle(
                                  color: Colors.white24,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            trailing: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Color.fromARGB(137, 253, 250, 250),
                            ),
                          );
                        }
                      }
                    });
          }),
    ]);
  }
}
