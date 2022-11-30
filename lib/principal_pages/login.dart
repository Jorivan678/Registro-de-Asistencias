import 'package:flutter/material.dart';

import '../share_prefs/prefs_user.dart';
import 'assist_app_theme.dart';
import 'assist_home_screen.dart';
import 'model/login_model.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final prefUser = PrefUser();
  TextEditingController usuario = TextEditingController(text: '');
  TextEditingController contrasenia = TextEditingController(text: '');
  Login loginModen = Login();
  Future<bool> cuentaIniciada() async {
    return prefUser.inicioSesion;
  }

  Future<String?> showDialogMethod(String contenido) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                constraints:
                    const BoxConstraints(minHeight: 100, maxHeight: 300),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 75,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      contenido,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            return AssistAppTheme.buildLightTheme()
                                .primaryColor;
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cerrar'),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cuentaIniciada(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (prefUser.inicioSesion) {
            Future.microtask(() {
              Navigator.pushReplacementNamed(
                  context, AssistHomeScreen.routeName);
            });
          } else {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/login.png'),
                    fit: BoxFit.cover),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 35, top: 130),
                      child: const Text(
                        'Bienvenido\nde vuelta',
                        style: TextStyle(color: Colors.white, fontSize: 33),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 35, right: 35),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: usuario,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        hintText: "Usuario",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(),
                                    controller: contrasenia,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        hintText: "Contraseña",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        child: const Text('Iniciar Sesión',
                                            style: TextStyle(
                                                fontSize: 27,
                                                fontWeight: FontWeight.w700)),
                                        onPressed: () async {
                                          loginModen =
                                              await Login.iniciarSesion(
                                                  usuario.text,
                                                  contrasenia.text);
                                          if (!loginModen.lError &&
                                              loginModen.lValido) {
                                            Future.microtask(() {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  AssistHomeScreen.routeName);
                                            });
                                          } else if (loginModen.lError) {
                                            showDialogMethod(
                                                "Ocurrio un error en el sistema");
                                          } else if (!loginModen.lValido) {
                                            showDialogMethod(
                                                "El usuario o contraseña son incorrectos");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return const Scaffold(body: Text(''));
      },
    );
  }
}
