import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../share_prefs/prefs_user.dart';
import 'constantes.dart';

class Login {
  Login(
      {this.cNombre = '',
      this.cFolioUsuario = '',
      this.cError = '',
      this.lValido = false,
      this.lError = false});
  String cNombre;
  String cFolioUsuario;
  String cError;
  bool lValido;
  bool lError;

  static Future<Login> iniciarSesion(
      String cFolioEmpleado, String cContrasenia) async {
    Login oRespuesta =
        Login(lError: true, cError: "ocurrio un error en el servidor");
    final prefUser = PrefUser();

    final response = await http.post(
      Uri.parse(
          '${Constantes.cUrlBase}controller/consumir.php?op=iniciarsesion'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {"logina": cFolioEmpleado, "clavea": cContrasenia},
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      if (!responseJson["lError"]) {
        oRespuesta = Login.fromJson(responseJson["data"]);
        prefUser.inicioSesion = oRespuesta.lValido;
        prefUser.nombreUsuario = oRespuesta.cNombre;
        prefUser.folioUsuario = oRespuesta.cFolioUsuario;
      } else {
        oRespuesta = Login(lError: true, cError: responseJson["sError"]);
      }
    }

    return oRespuesta;
  }

  static bool cerrarSesion() {
    final prefUser = PrefUser();
    prefUser.inicioSesion = false;
    prefUser.nombreUsuario = "";
    prefUser.folioUsuario = "";
    return true;
  }

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        lValido: json["lValido"],
        cFolioUsuario: json["num_usuario"],
        cNombre: json["nombre"],
        cError: "",
        lError: false);
  }
}
