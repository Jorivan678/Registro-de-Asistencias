import 'package:app_dummy_10a/principal_pages/assist_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateReportScreen extends StatefulWidget {
  final String folio;
  final int id;
  final DateTime fecha;
  const CreateReportScreen(
      {Key? key, required this.folio, required this.id, required this.fecha})
      : super(key: key);

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final _formkey = GlobalKey<FormState>();
  late int _selectedPosition = 0;
  final List<String> opciones = ["Entrada", "Salida"];
  late String tipo = '';

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
                "Reportar incidencia",
                style: (TextStyle(
                    color: isLightMode ? Colors.black : Colors.white)),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('Inicio');
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
            body: _buildForm(widget.fecha, widget.id, widget.folio)),
      ),
    );
  }

  Widget _buildForm(DateTime fecha, int id, String folio) {
    TextEditingController date = TextEditingController(
        text: DateFormat("yyyy-MM-dd").format(fecha).toString());
    TextEditingController desc = TextEditingController();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
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
                  Text(
                    'Fecha de la incidencia',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
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
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xFFE0F7FA),
                      filled: true,
                      prefixIcon: Icon(Icons.date_range),
                      focusedBorder: OutlineInputBorder(
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
                        fontWeight: FontWeight.w300,
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
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xFFE0F7FA),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff14DAE2), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    controller: desc,
                    readOnly: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Donde está el problema:",
                          style: TextStyle(
                            color: isLightMode ? Colors.black : Colors.white,
                          )),
                      Container(
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: false,
                            itemBuilder: (context, position) {
                              return _createList(
                                  context, opciones[position], position);
                            },
                            itemCount: opciones.length,
                          ))
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text('Enviar reporte'))
                      ])
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  _createList(context, item, position) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _updateState(position);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Radio(
            focusColor: Colors.grey,
            value: _selectedPosition,
            groupValue: position,
            fillColor: MaterialStateColor.resolveWith((states) => Colors.grey),
            onChanged: (_) {
              _updateState(position);
            },
          ),
          Text(
            item,
            style: TextStyle(color: isLightMode ? Colors.black : Colors.white),
          ),
        ],
      ),
    );
  }

  _updateState(int position) {
    setState(() {
      _selectedPosition = position;
    });
    onTypeChange(opciones[position]);
  }

  void onTypeChange(String opcion) async {
    tipo = opcion;
  }
}
