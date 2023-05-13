import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:registro_conducta_app_v2/src/services/sevices_data.dart';

// ignore: camel_case_types
class info_pensamiento extends StatelessWidget {
  final String pensamiento;
  final String name_patiens;
  final String uid;

  const info_pensamiento(this.pensamiento, this.uid, this.name_patiens,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Vista de Registros"),
          backgroundColor: const Color.fromARGB(255, 9, 54, 70)),
      body: cuerpo(context),
      backgroundColor: Color.fromARGB(255, 221, 219, 219),
    );
  }

  Widget cuerpo(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [contenedor(context)],
    );
  }

  Widget contenedor(BuildContext context) {
    Future getSuperAdmin() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('role', isEqualTo: 'psicologo')
          .get();
      return querySnapshot.docs;
    }

    Future getRegisters() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('registros_pensamientos')
          .where('userUID', isEqualTo: uid)
          .orderBy('hora_registro', descending: true)
          .limit(1)
          .get();
      return querySnapshot.docs;
    }

    return Container(
        child: Column(children: <Widget>[
// Logo y Nombre del consultorio
      Table(
        children: [
          TableRow(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'C A P A D E',
                    style: TextStyle(fontSize: 28, color: Colors.orangeAccent),
                  ),
                  Text('Centro de Atención Psicológica',
                      style: pwTableHeadingTextStyle(),
                      textAlign: TextAlign.right),
                  Text('para Ansiedad y Depresión',
                      textAlign: TextAlign.right,
                      style: pwTableHeadingTextStyle()),

                  //
                ],
              ),
            ],
          ),
        ],
        //
      ),
      Divider(color: Color.fromARGB(255, 221, 219, 219), thickness: 10),
// Fecha y nombre del psicologo
      FutureBuilder(
          future: getSuperAdmin(),
          builder: (_, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  DocumentSnapshot data = snapshot.data[index];

                  return Table(children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Psicologo',
                                style: pwTableHeadingTextStyle(),
                              ),
                              Text(data['nombre'],
                                  style: pwTableHeadingTextStyle()),
                            ],
                          ),
                        ),
                        FutureBuilder(
                            future: getRegisters(),
                            builder: (_, snapshot) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length ?? 0,
                                  itemBuilder: (_, index) {
                                    DocumentSnapshot data =
                                        snapshot.data[index];

                                    return Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Fecha y hora de registro',
                                              style: pwTableHeadingTextStyle(),
                                            ),
                                            Text(
                                              formatTime(data['hora_registro']),
                                              style: pwTableHeadingTextStyle(),
                                            ),
                                          ]),
                                    );
                                  });
                            })
                      ],
                    ),
                  ]);
                });
          }),

//Nombre del paciente
      Table(children: [
        TableRow(children: [
          Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre del paciente',
                  style: pwTableHeadingTextStyle(),
                ),
                Text(name_patiens, style: pwTableHeadingTextStyle()),
              ],
            ),
          ),
        ]),
      ]),
      //Gap
      Divider(color: Color.fromARGB(255, 221, 219, 219), thickness: 20),
      //Section Header: Stocked Items
      Padding(
        padding: EdgeInsets.all(2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Divider(),
          Text(
            'Registro de Ansiedad/Malestar',
            style: pwTableHeading(),
          ),
          const Divider()
        ]),
      ),

      // Stocked Items Table
      // Next Table
      Table(border: TableBorder.all(), children: [
        TableRow(
          children: [
            paddedHeadingTextCell('Situacion'),
            paddedHeadingTextCell('Pensamientos'),
            paddedHeadingTextCell('Emociones'),
            paddedHeadingTextCell('Sensaciones Físicas'),
            paddedHeadingTextCell('Conducta/Respuesta'),
          ],
        ),
        // Now the next table row

        buildRowsForInventoryItems(),
      ]),
    ]));
  }

  TableRow buildRowsForInventoryItems() {
    Future getRegisters() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('registros_pensamientos')
          .where('userUID', isEqualTo: uid)
          .orderBy('hora_registro', descending: true)
          .limit(1)
          .get();
      return querySnapshot.docs;
    }

    List<Column> itemList = [];

    itemList.add(
      Column(
        children: [
          FutureBuilder(
              future: getRegisters(),
              builder: (_, snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (_, index) {
                      DocumentSnapshot data = snapshot.data[index];

                      return Column(
                        children: [
                          paddedTextCell(data['Situacion']),
                        ],
                      );
                    });
              }),
        ],
      ),
    );
    itemList.add(
      Column(
        children: [
          FutureBuilder(
              future: getRegisters(),
              builder: (_, snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (_, index) {
                      DocumentSnapshot data = snapshot.data[index];

                      return Column(
                        children: [
                          paddedTextCell(data['Pensamientos']),
                        ],
                      );
                    });
              }),
        ],
      ),
    );
    itemList.add(
      Column(
        children: [
          FutureBuilder(
              future: getRegisters(),
              builder: (_, snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (_, index) {
                      DocumentSnapshot data = snapshot.data[index];

                      return Column(
                        children: [
                          paddedTextCell(data['Emociones']),
                        ],
                      );
                    });
              }),
        ],
      ),
    );
    itemList.add(
      Column(
        children: [
          FutureBuilder(
              future: getRegisters(),
              builder: (_, snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (_, index) {
                      DocumentSnapshot data = snapshot.data[index];

                      return Column(
                        children: [
                          paddedTextCell(data['sensacion_fisica']),
                        ],
                      );
                    });
              }),
        ],
      ),
    );
    itemList.add(
      Column(
        children: [
          FutureBuilder(
              future: getRegisters(),
              builder: (_, snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (_, index) {
                      DocumentSnapshot data = snapshot.data[index];

                      return Column(
                        children: [
                          paddedTextCell(data['conducta_respuesta']),
                        ],
                      );
                    });
              }),
        ],
      ),
    );
    return TableRow(children: itemList);
  }

  TextStyle pwTableHeadingTextStyle() =>
      TextStyle(fontSize: 10, fontWeight: FontWeight.bold);

  TextStyle pwTableHeading() =>
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  Padding paddedTextCell(String textContent) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(textContent, textAlign: TextAlign.left),
      ]),
    );
  }

  Padding paddedHeadingTextCell(String textContent) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(children: [
        Text(
          textContent,
          style: pwTableHeadingTextStyle(),
        ),
      ]),
    );
  }
}
