import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registro_conducta_app_v2/src/pages/login/login.dart';
import 'package:registro_conducta_app_v2/src/pages/patients/pmain.dart';
import 'package:registro_conducta_app_v2/src/pages/psychologist/wmain.dart';
import 'package:registro_conducta_app_v2/main.dart';
// import 'model.dart';

class reset_pass extends StatefulWidget {
  @override
  _reset_pass createState() => _reset_pass();
}

class _reset_pass extends State<reset_pass> {
  _reset_pass();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://i.ibb.co/HH4S35K/Imagen-por-pablo-lexo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(30),
      child: ListView(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 50.0,
              sigmaY: 50.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              // color: Colors.white.withOpacity(0.5),
              child: Column(children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Recuperar Contraseña",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10.0),
                          child: const Image(
                            image: NetworkImage(
                                'https://i.ibb.co/vDfqWzG/logo-psyco2.png'),
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Correo Electronico',
                            enabled: true,
                            contentPadding: EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Debe llenarlo";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Ingresa un correo electronico valido");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              elevation: 3.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                  Navigator.of(context).pop();
                                });
                              },
                              color: Colors.white,
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              elevation: 3.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                if (_formkey.currentState!.validate()) {
                                  _auth.sendPasswordResetEmail(
                                      email: emailController.text);
                                  Navigator.of(context).pop();
                                }
                              },
                              color: Colors.blue,
                              child: const Text(
                                "Enviar",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    ));
  }
}
