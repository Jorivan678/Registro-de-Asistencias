import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'assist_list_data.dart';
import 'constantes.dart';

class RecordsData {
  RecordsData(
      {this.cfolioEmpleado = '',
      required this.oRegistros,
      this.cHoraEntrada = '',
      this.cHoraSalida = '',
      this.cError = '',
      this.lError = false});
  String cfolioEmpleado;
  List<AssistListData> oRegistros;
  String cHoraEntrada;
  String cHoraSalida;
  String cError;
  bool lError;

  static Future<RecordsData> obtenerRegistros(
      String cFolioEmpleado, DateTime? dtFechaIni, DateTime? dtFechaFin) async {
    RecordsData oRespuesta = RecordsData(
        oRegistros: [],
        lError: true,
        cError: "ocurrio un error en el servidor");

    final response = await http.post(
      Uri.parse(
          '${Constantes.cUrlBase}controller/consumir.php?op=obtenerasistencias'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "personId": cFolioEmpleado,
        "startTime": dtFechaIni != null
            ? DateFormat("yyyy-MM-dd").format(dtFechaIni)
            : "",
        "endTime": dtFechaFin != null
            ? DateFormat("yyyy-MM-dd").format(dtFechaFin)
            : ""
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      if (!responseJson["lError"]) {
        oRespuesta = RecordsData.fromJson(responseJson["data"]);
      } else {
        oRespuesta = RecordsData(
            oRegistros: [], lError: true, cError: responseJson["sError"]);
      }
    }

    return oRespuesta;
  }

  factory RecordsData.fromJson(Map<String, dynamic> json) {
    return RecordsData(
        cfolioEmpleado: json["folio"],
        oRegistros: List<AssistListData>.from(json['registros']
            .map((x) => AssistListData.fromJson(x, json["folio"]))),
        cHoraEntrada: json["hora_entrada"],
        cHoraSalida: json["hora_salida"],
        cError: "",
        lError: false);
  }
}
