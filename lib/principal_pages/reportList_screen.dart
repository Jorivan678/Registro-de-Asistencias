import 'package:app_dummy_10a/principal_pages/assist_app_theme.dart';
import 'package:app_dummy_10a/principal_pages/report_list_view.dart';
import 'package:flutter/material.dart';

import '../share_prefs/prefs_user.dart';
import 'model/reports.dart';

class ReportListScreen extends StatefulWidget {
  const ReportListScreen({Key? key}) : super(key: key);

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Report reportList = Report(oReportes: []);
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  final prefUser = PrefUser();
  DateTime curentDay = DateTime.now();
  int numRegistros = 0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    refreshIncidencias();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future refreshIncidencias() async {
    setState(() => isLoading = true);
    reportList = await Report.obtenerRegistros(prefUser.folioUsuario);

    setState(() => {
          isLoading = false,
          numRegistros = reportList.oReportes.length,
        });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Theme(
      data: isLightMode
          ? AssistAppTheme.buildLightTheme()
          : AssistAppTheme.buildDarkTheme(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Column(
                children: <Widget>[
                  getAppBarUI(),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  getFilterBarUI(),
                                ],
                              );
                            }, childCount: 1),
                          ),
                        ];
                      },
                      body: RefreshIndicator(
                        onRefresh: () async {
                          refreshIncidencias();
                        },
                        child: Container(
                          color: isLightMode
                              ? AssistAppTheme.buildLightTheme().backgroundColor
                              : AssistAppTheme.buildDarkTheme().backgroundColor,
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : reportList.oReportes.isEmpty
                                  ? const Center(
                                      child:
                                          Text("No se encontraron registros"),
                                    )
                                  : ListView.builder(
                                      itemCount: reportList.oReportes.length,
                                      padding: const EdgeInsets.only(top: 8),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final int count =
                                            reportList.oReportes.length > 10
                                                ? 10
                                                : reportList.oReportes.length;
                                        final Animation<double> animation =
                                            Tween<double>(begin: 0.0, end: 1.0)
                                                .animate(CurvedAnimation(
                                                    parent:
                                                        animationController!,
                                                    curve: Interval(
                                                        (1 / count) * index,
                                                        1.0,
                                                        curve: Curves
                                                            .fastOutSlowIn)));
                                        animationController?.forward();
                                        return ReportListView(
                                          callback: () {},
                                          reportData:
                                              reportList.oReportes[index],
                                          animation: animation,
                                          animationController:
                                              animationController!,
                                        );
                                      },
                                    ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
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
              blurRadius: 8.0),
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
                color: isLightMode ? Colors.white : Colors.black,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Lista de incidencias reportadas',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: isLightMode ? Colors.black : Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFilterBarUI() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: isLightMode
                  ? AssistAppTheme.buildLightTheme().backgroundColor
                  : AssistAppTheme.buildDarkTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: isLightMode
              ? AssistAppTheme.buildLightTheme().backgroundColor
              : AssistAppTheme.buildDarkTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$numRegistros registros encontrados.',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}
