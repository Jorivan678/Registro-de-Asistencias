import 'dart:convert';

import 'package:http/http.dart' as http;

import 'constantes.dart';

class Report {
  Report({this.cError = '', this.lError = false, required this.oReportes});
  List<ReportData> oReportes;
  String cError;
  bool lError;

  static Future<dynamic> crearRegistros(
      int iIdHorario,
      String cFolioEmpleado,
      String cTipoIncidencia,
      String dtFechaIncidencia,
      String cDesIncidencia) async {
    final response = await http.post(
      Uri.parse('${Constantes.cUrlBase}controller/incidencia.php?op=insertar'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "idhorario": "$iIdHorario",
        "num_usuario": cFolioEmpleado,
        "tipo_incidencia": cTipoIncidencia,
        "des_peticion": cDesIncidencia,
        "fecha_incidencia": dtFechaIncidencia,
      },
    );
    dynamic oRespuesta = 0;

    if (response.statusCode == 200) {
      oRespuesta = json.decode(response.body);
    }

    return oRespuesta;
  }

  static Future<Report> obtenerRegistros(String cFolioEmpleado) async {
    Report oRespuesta = Report(
        lError: true, cError: "ocurrio un error en el servidor", oReportes: []);

    final response = await http.post(
      Uri.parse(
          '${Constantes.cUrlBase}controller/consumir.php?op=consultarincidencias'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {"numusuario": cFolioEmpleado},
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      if (!responseJson["lError"]) {
        oRespuesta = Report.fromJson(responseJson);
      } else {
        oRespuesta =
            Report(oReportes: [], lError: true, cError: responseJson["sError"]);
      }
    }

    return oRespuesta;
  }

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        oReportes: List<ReportData>.from(
            json['data'].map((x) => ReportData.fromJson(x))),
        cError: "",
        lError: false);
  }
}

class ReportData {
  ReportData({
    this.iIdHorario = 0,
    required this.cNumUsuario,
    required this.cTipoEntrada,
    this.cObservacion = '',
    this.cDesPeticion = '',
    required this.dtFechaIncidencia,
    this.dtFechaAtendida,
    this.lAtendida = false,
    this.cAceptada = "",
  });
  int iIdHorario;
  String cNumUsuario;
  String cTipoEntrada;
  String cObservacion;
  String cDesPeticion;
  String cAceptada;
  DateTime dtFechaIncidencia;
  DateTime? dtFechaAtendida;
  bool lAtendida;

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
        iIdHorario: int.parse(json["idhorario"]),
        cNumUsuario: json["num_usuario"],
        cTipoEntrada: json["tipo_incidencia"],
        cObservacion: json["observacion"],
        cDesPeticion: json["des_peticion"],
        dtFechaAtendida: (json["fecha_atendida"] != null)
            ? DateTime.parse(json["fecha_atendida"])
            : null,
        dtFechaIncidencia: DateTime.parse(json["fecha_incidencia"]),
        lAtendida: (json["latendida"] == "1") ? true : false,
        cAceptada: (json["laceptada"] == "1")
            ? "aceptada"
            : (json["laceptada"] == "0")
                ? "rechazada"
                : "no atendida");
  }
}
