import 'package:app_dummy_10a/principal_pages/assist_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../share_prefs/prefs_user.dart';
import 'model/reports.dart';

class CreateReportScreen extends StatefulWidget {
  final int iIdHorario;
  final String cTipoIncidencia;
  final DateTime dtFechaIncidencia;

  const CreateReportScreen({
    Key? key,
    required this.iIdHorario,
    required this.cTipoIncidencia,
    required this.dtFechaIncidencia,
  }) : super(key: key);

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController(text: '');
  TextEditingController desc = TextEditingController();
  final prefUser = PrefUser();
  final List<String> opciones = ["Entrada", "Salida"];
  late String dropdownValue = '';
  @override
  void initState() {
    super.initState();
    if (widget.cTipoIncidencia == "") {
      dropdownValue = opciones.first;
    } else {
      dropdownValue =
          opciones.firstWhere((element) => element == widget.cTipoIncidencia);
    }
    dateInput.text = DateFormat("yyyy-MM-dd", 'es')
        .format(widget.dtFechaIncidencia)
        .toString();
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
                "Reportar incidencia",
                style: (TextStyle(
                    color: isLightMode ? Colors.black : Colors.white)),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
            body: _buildForm()),
      ),
    );
  }

  Widget _buildForm() {
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
                  DropdownButtonFormField(
                    value: dropdownValue,
                    isExpanded: true,
                    alignment: Alignment.center,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    elevation: 16,
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
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items:
                        opciones.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
                    controller: dateInput,
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
                        Icons.calendar_month,
                        color: colorFondo,
                      ),
                      labelStyle: TextStyle(color: colorFondo),
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: colorFondo, // header background color
                                onPrimary: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
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
                    controller: desc,
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: 4,
                    readOnly: false,
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
                        Icons.short_text,
                        color: colorFondo,
                      ),
                      labelStyle: TextStyle(color: colorFondo),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  return AssistAppTheme.buildLightTheme()
                                      .primaryColor;
                                }),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            onPressed: () async {
                              var registro = await Report.crearRegistros(
                                  widget.iIdHorario,
                                  prefUser.folioUsuario,
                                  dropdownValue,
                                  dateInput.text,
                                  desc.text);
                              if (!registro["lError"] && registro["data"] > 0) {
                                Future.microtask(() {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: const Text(
                              'Enviar reporte',
                              style: TextStyle(fontSize: 24),
                            ))
                      ])
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
