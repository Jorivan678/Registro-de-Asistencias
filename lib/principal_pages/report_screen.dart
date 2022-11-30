import 'package:app_dummy_10a/principal_pages/assist_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  final int idHorario;
  final String cTipoIncidencia;
  final String cPeticion;
  final String cRespuesta;
  final DateTime dtFechaIncidencia;
  const ReportScreen(
      {Key? key,
      required this.idHorario,
      required this.cTipoIncidencia,
      required this.cPeticion,
      required this.dtFechaIncidencia,
      required this.cRespuesta})
      : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formkey = GlobalKey<FormState>();
  final List<String> opciones = ["Entrada", "Salida"];
  late String tipo = '';

  @override
  void initState() {
    tipo = widget.cTipoIncidencia;
    super.initState();
    initializeDateFormatting('es');
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      color: isLightMode
          ? AssistAppTheme.buildLightTheme().backgroundColor
          : AssistAppTheme.buildDarkTheme().backgroundColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: isLightMode
                  ? AssistAppTheme.buildLightTheme().backgroundColor
                  : AssistAppTheme.buildDarkTheme().backgroundColor,
              title: Text(
                "Detalles del reporte de incidencia",
                style: (TextStyle(
                    color: isLightMode ? Colors.black : Colors.white)),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('Incidencias');
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: isLightMode ? Colors.black : Colors.white,
                ),
              ),
            ),
            backgroundColor: isLightMode
                ? AssistAppTheme.buildLightTheme().backgroundColor
                : AssistAppTheme.buildDarkTheme().backgroundColor,
            body: _buildForm(widget.dtFechaIncidencia, widget.idHorario,
                widget.cTipoIncidencia, widget.cPeticion, widget.cRespuesta)),
      ),
    );
  }

  Widget _buildForm(DateTime fecha, int id, String tipoIncidencia,
      String peticion, String respuesta) {
    TextEditingController inc = TextEditingController(text: tipoIncidencia);
    TextEditingController date = TextEditingController(
        text: DateFormat("yyyy-MM-dd", 'es').format(fecha).toString());
    TextEditingController desc = TextEditingController(text: peticion);
    TextEditingController resp = TextEditingController(text: respuesta);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    Color colorFondo = isLightMode
        ? AssistAppTheme.buildLightTheme().primaryColor
        : AssistAppTheme.buildDarkTheme().primaryColor;
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Tipo Incidencia:",
                      style: TextStyle(
                        color: isLightMode ? Colors.black : Colors.white,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colorFondo),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorFondo,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock_clock,
                        color: colorFondo,
                      ),
                      labelStyle: TextStyle(color: colorFondo),
                    ),
                    controller: inc,
                    readOnly: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Fecha de la incidencia',
                    style: TextStyle(
                        fontSize: 15,
                        color: isLightMode ? Colors.black : Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: (const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
                    keyboardType: TextInputType.datetime,
                    cursorColor: Colors.white,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorFondo,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: colorFondo,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff14DAE2), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    controller: date,
                    readOnly: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Descripción del problema',
                    style: TextStyle(
                        fontSize: 15,
                        color: isLightMode ? Colors.black : Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: (const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: null,
                    cursorColor: Colors.white,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorFondo,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.short_text,
                        color: colorFondo,
                      ),
                      border: InputBorder.none,
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff14DAE2), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    controller: desc,
                    readOnly: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Respuesta',
                    style: TextStyle(
                        fontSize: 15,
                        color: isLightMode ? Colors.black : Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: (const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: null,
                    cursorColor: Colors.white,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorFondo,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.short_text,
                        color: colorFondo,
                      ),
                      border: InputBorder.none,
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff14DAE2), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    controller: resp,
                    readOnly: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void onTypeChange(String opcion) async {
    tipo = opcion;
  }
}
