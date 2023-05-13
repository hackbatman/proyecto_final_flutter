import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';
import 'dart:ui';

import 'package:registro_conducta_app_v2/src/services/sevices_data.dart';

// ignore: must_be_immutable
class report_animo extends StatefulWidget {
  DocumentSnapshot docid;
  String nombre;
  report_animo({required this.docid, required this.nombre});
  @override
  State<report_animo> createState() =>
      _report_pensamientoState(docid: docid, nombre: nombre);
}

class _report_pensamientoState extends State<report_animo> {
  DocumentSnapshot docid;
  String nombre;
  _report_pensamientoState({required this.docid, required this.nombre});
  final pdf = pw.Document();

  var fecha;
  var nombr;
  var actividad;
  var estado_animo;
  var select_dom;
  var trap_trac;

  void initState() {
    setState(() {
      fecha = formatTiempo(widget.docid.get('hora_registro'));
      nombr = widget.nombre;
      actividad = widget.docid.get('Actividad');
      estado_animo = widget.docid.get('estado_animo');
      select_dom = widget.docid.get('select_dom');
      trap_trac = widget.docid.get('trap_trac');
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
                      'Registro de Estado de Animo',
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
                  paddedHeadingTextCell('Actividades'),
                  paddedHeadingTextCell('Estado de animo (1-10)'),
                  paddedHeadingTextCell('Dominio'),
                  paddedHeadingTextCell('Trap o Trac'),
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
          pw.Text(actividad),
        ],
      ),
    );
    itemList.add(
      pw.Column(
        children: [
          pw.Text(estado_animo),
        ],
      ),
    );
    itemList.add(
      pw.Column(
        children: [
          pw.Text(select_dom),
        ],
      ),
    );
    itemList.add(
      pw.Column(
        children: [
          pw.Text(trap_trac),
        ],
      ),
    );

    return pw.TableRow(children: itemList);
  }

  pw.TextStyle pwTableHeadingTextStyle() =>
      pw.TextStyle(fontWeight: pw.FontWeight.bold);

  pw.TextStyle pwTableHeading() =>
      pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20);

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
