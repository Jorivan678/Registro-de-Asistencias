import 'package:app_dummy_10a/principal_pages/model/register_list_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../share_prefs/prefs_user.dart';
import 'assist_app_theme.dart';
import 'package:app_dummy_10a/principal_pages/calendar_popup_view.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'assist_list_view.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen>
    with TickerProviderStateMixin {
  DateTime startDate = DateTime.now().add(const Duration(days: -1));
  DateTime endDate = DateTime.now();
  AnimationController? animationController;
  RecordsData registros = RecordsData(oRegistros: []);
  int numRegistros = 0;
  final prefUser = PrefUser();
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    initializeDateFormatting('es');
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future refreshRegistros() async {
    setState(() => {});
    registros = await RecordsData.obtenerRegistros(
        prefUser.folioUsuario, startDate, endDate);

    if (registros.lError) {
      showDialogMethod("Ocurrio un error");
    } else if (registros.oRegistros.isEmpty) {
      showDialogMethod("No se encontraron registros");
    }

    setState(() => {
          numRegistros = registros.oRegistros.length,
        });
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
                    const BoxConstraints(minHeight: 100, maxHeight: 250),
                child: Column(
                  children: [
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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      color: isLightMode
          ? AssistAppTheme.buildLightTheme().backgroundColor
          : AssistAppTheme.buildDarkTheme().backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            dateFilter(),
            const Divider(
              height: 1,
            ),
            Expanded(
              child: numRegistros <= 0
                  ? const Text("")
                  : ListView.builder(
                      itemCount: numRegistros,
                      padding: const EdgeInsets.only(top: 8),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final int count = numRegistros > 10 ? 10 : numRegistros;
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn)));
                        animationController?.forward();
                        return AssistListView(
                          callback: () {},
                          assistData: registros.oRegistros[index],
                          animation: animation,
                          animationController: animationController!,
                        );
                      },
                    ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: isLightMode
                      ? AssistAppTheme.buildLightTheme().primaryColor
                      : AssistAppTheme.buildDarkTheme().primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: refreshRegistros,
                    child: const Center(
                      child: Text(
                        'Aplicar',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dateFilter() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Material(
        color: isLightMode
            ? AssistAppTheme.buildLightTheme().backgroundColor
            : AssistAppTheme.buildDarkTheme().backgroundColor,
        child: InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(4.0),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              /*setState(() {
                isDatePopupOpen = true;
              });*/
              showDemoDialog(context: context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Rango de fechas',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: isLightMode ? Colors.black : Colors.white,
                        fontSize:
                            MediaQuery.of(context).size.width > 360 ? 18 : 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Text(
                  '${DateFormat("dd MMM", 'es').format(startDate)} - ${DateFormat("dd MMM", 'es').format(endDate)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            )));
  }

  Widget getAppBarUI() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      decoration: BoxDecoration(
        color: isLightMode
            ? AssistAppTheme.buildLightTheme().backgroundColor
            : AssistAppTheme.buildDarkTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: isLightMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Filtro',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: isLightMode ? Colors.black : Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        maximumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }
}
