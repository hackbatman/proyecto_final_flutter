// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registro_conducta_app_v2/main.dart';
import 'package:registro_conducta_app_v2/src/pages/patients/pmain.dart';
import 'dart:ui';
import 'package:registro_conducta_app_v2/src/pages/psychologist/wmain.dart';
import 'package:registro_conducta_app_v2/src/services/registro.dart';
import 'package:registro_conducta_app_v2/src/services/reset_pass.dart';

@override
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  //FirebaseAuth auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final pass = TextEditingController();
  bool showProgress = false;
  bool visible = false;
  bool _isObscure = true;
  bool _isObscure2 = true;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10.0),
                          child: const Image(
                            image: NetworkImage(
                                'https://i.ibb.co/vDfqWzG/logo-psyco2.png'),
                            height: 100,
                          ),
                        ),
                        const ListTile(
                          title: Text(
                            "C A P A D E",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          subtitle: Text(
                            "Centro de Atencion Psicológica para Ansiedad y Depresion",
                            textAlign: TextAlign.center,
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
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.people),
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
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Contraseña',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Debe llenarlo";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Escribir contraseña con  6 caracteres minimo");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            setState(() {
                              showProgress = true;
                            });
                            SignIn();
                          },
                          color: Colors.blue,
                          child: const Text(
                            "Iniciar sesion",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Aun no esta registrado?',
                                style: TextStyle(
                                  color: Colors.white30,
                                ),
                              ),
                              TextButton(
                                child: const Text(
                                  'Registrarse',
                                  style: TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Registro()));
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => reset_pass()));
                                },
                                child: const Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

  // ignore: non_constant_identifier_names
  Future SignIn() async {
    if (_formkey.currentState!.validate()) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      const CircularProgressIndicator();

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        AccessRole();
      } on FirebaseAuthException catch (e) {
        String error = e.message.toString();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: const Text("Mensaje de error"),
                    content: Text(error),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cerrar"),
                      ),
                    ]));
      }
    }
  }

  AccessRole() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "psicologo") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Wmain(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ModMenu(),
            ),
          );
        }
      } else {
        // ignore: avoid_print
        print('Document does not exist on the database');
      }
    });
  }
}
