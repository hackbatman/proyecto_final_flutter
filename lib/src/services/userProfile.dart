import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final String idUsuario = user.uid;
    TextEditingController getName = TextEditingController();

    Future getData() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where("uid", isEqualTo: idUsuario)
          .get();
      return querySnapshot.docs;
    }

    final firebase = FirebaseFirestore.instance;
    updatename() async {
      try {
        await firebase.collection("users").doc(idUsuario).update({
          "nombre": getName.text,
        });
      } catch (e) {
        print('Error in the database' + e.toString());
      }
    }

    return FutureBuilder(
        future: getData(),
        builder: (_, snapshot) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (_, index) {
                DocumentSnapshot data = snapshot.data[index];

                return Container(
                  padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: Stack(children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1))
                                  ],
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://cdn-icons-png.flaticon.com/512/149/149071.png"))),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                      color: Colors.blue),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ))
                          ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.00),
                          decoration: const BoxDecoration(
                              //   color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          // height: 350.0,
                          child: Column(children: <Widget>[
                            ListTile(
                                title: Center(
                                  child: Text(
                                    data['nombre'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ),
                                subtitle: Center(
                                  child: Text(
                                    data['role'],
                                    style: const TextStyle(
                                        color: Colors.white24,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                )),
                          ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                OpenDialog(context, updatename(),
                                    data['nombre'], getName);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                              ),
                              child: const Text(
                                "Editar",
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }

  void OpenDialog(
      BuildContext context, var metodo, String label, var controlador) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Nombre'),
        content: bulTextField("Nombre", label, false, controlador),
        backgroundColor: const Color.fromARGB(255, 9, 54, 70),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Salir")),
          TextButton(
              onPressed: () {
                metodo;
                Navigator.pop(context);
              },
              child: const Text("Guardar")),
        ],
      ),
    );
  }

  Widget bulTextField(String labelText, String placeholder,
      bool isPasswordTextField, var controller) {
    bool isObscurePassword = false;
    return Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.only(bottom: 30),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          obscureText: isPasswordTextField ? isObscurePassword : false,
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(255, 8, 197, 255)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(255, 247, 247, 247)),
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    width: 1,
                  )),
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      onPressed: (() {}),
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ))
                  : null,
              contentPadding: const EdgeInsets.only(bottom: 5),
              labelText: labelText,
              labelStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
        ));
  }
}
