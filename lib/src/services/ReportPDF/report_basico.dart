import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:ui';
import 'package:registro_conducta_app_v2/src/services/sevices_data.dart';

class report_basico extends StatefulWidget {
  DocumentSnapshot docid;
  String nombre;
  report_basico({required this.docid, required this.nombre});
  @override
  State<report_basico> createState() =>
      _reporttState(docid: docid, nombre: nombre);
}

class _reporttState extends State<report_basico> {
  DocumentSnapshot docid;
  String nombre;
  _reporttState({required this.docid, required this.nombre});

  final pdf = pw.Document();
  var emociones;
  var pensamientos;
  var respuestas;
  var situacion;
  var cambio;
  var nombr;
  var fecha;

  void initState() {
    setState(() {
      situacion = widget.docid.get('Situacion');
      pensamientos = widget.docid.get('Pensamientos');
      emociones = widget.docid.get('Emociones');
      respuestas = widget.docid.get('Respuestas');
      cambio = widget.docid.get("cambio");
      fecha = formatTiempo(widget.docid.get('hora_registro'));

      nombr = widget.nombre;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pdf = pw.Document();

    final bytes = pdf.save();
    return PdfPreview(
      //maxPageWidth: 1000,
      //useActions: false,
      canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,

      build: (format) => createPdfDocument(
        format,
      ),
    );
  }

  Future<Uint8List> createPdfDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final netImage =
        await networkImage('https://i.ibb.co/vDfqWzG/logo-psyco2.png');

    doc.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(31), // This is the page margin
        build: (pw.Context context) {
          return <pw.Widget>[
// Logo y Nombre del consultorio
            pw.Table(
              children: [
                pw.TableRow(
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          child: pw.Image(
                            netImage,
                            height: 90,
                          ),
                        )
                      ],
                    ),
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'C A P A D E',
                          style: pw.TextStyle(
                              fontSize: 28, color: PdfColors.deepOrange400),
                        ),
                        pw.Text('Centro de Atención Psicológica',
                            textAlign: pw.TextAlign.right),
                        pw.Text('para Ansiedad y Depresión',
                            textAlign: pw.TextAlign.right),

                        //
                      ],
                    ),
                  ],
                ),
              ],
              //
            ),
            pw.Divider(color: PdfColors.white, thickness: 20),

// Fecha y nombre del psicologo
            pw.Table(// This is the starting widget for the table
                children: [
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Psicologo',
                          style: pwTableHeadingTextStyle(),
                        ),
                        pw.Text("Angel Rodriguez Bustamante"),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            'Fecha',
                            style: pwTableHeadingTextStyle(),
                          ),
                          pw.Text(fecha),
                        ]),
                  ),
                ],
              ),
            ]),
//Nombre del paciente
            pw.Table(children: [
              pw.TableRow(children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(4),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Nombre del paciente',
                        style: pwTableHeadingTextStyle(),
                      ),
                      pw.Text(nombre),
                    ],
                  ),
                ),
              ]),
            ]),
            //Gap
            pw.Divider(color: PdfColors.white, thickness: 20),

            //Section Header: Stocked Items
            pw.Padding(
              padding: pw.EdgeInsets.all(4),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Header(text: ''),
                    pw.Text(
                      'Registro Basico',
                      style: pwTableHeading(),
                    ),
                    pw.Header(text: '')
                  ]),
            ),

            // Stocked Items Table
            // Next Table
            pw.Table(border: pw.TableBorder.all(), children: [
              pw.TableRow(
                children: [
                  paddedHeadingTextCell('Situacion'),
                  paddedHeadingTextCell('Pensamientos'),
                  paddedHeadingTextCell('Emociones'),
                  paddedHeadingTextCell('Respuesta'),
                  paddedHeadingTextCell('Que cambió o qué lograste'),
                ],
              ),
              // Now the next table row
              buildRowsForInventoryItems(),
            ]),
          ];
        }));
    return doc.save();
  }

  pw.TableRow buildRowsForInventoryItems() {
    List<pw.Column> itemList = [];

    itemList.add(
      pw.Column(
        children: [
          pw.Text(situacion, style: pwTamanio()),
        ],
      ),
    );
    itemList.add(
      pw.Column(
        children: [
          pw.Text(pensamientos, style: pwTamanio()),
        ],
      ),
    );
    itemList.add(
      pw.Column(
        children: [
          pw.Text(emociones, style: pwTamanio()),
        ],
      ),
    );
    itemList.add(
      pw.Column(
        children: [
          pw.Text(respuestas, style: pwTamanio()),
        ],
      ),
    );
    itemList.add(
      pw.Column(
        children: [
          pw.Text(cambio, style: pwTamanio()),
        ],
      ),
    );

    return pw.TableRow(children: itemList);
  }

  pw.TextStyle pwTableHeadingTextStyle() =>
      pw.TextStyle(fontWeight: pw.FontWeight.bold);

  pw.TextStyle pwTableHeading() =>
      pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20);
  pw.TextStyle pwTamanio() => pw.TextStyle(fontSize: 10);

  pw.Padding paddedTextCell(String textContent) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(4),
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(textContent, textAlign: pw.TextAlign.left),
      ]),
    );
  }

  pw.Padding paddedHeadingTextCell(String textContent) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(4),
      child: pw.Column(children: [
        pw.Text(
          textContent,
          style: pwTableHeadingTextStyle(),
        ),
      ]),
    );
  }
}
