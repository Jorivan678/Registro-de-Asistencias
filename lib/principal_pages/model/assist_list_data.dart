class AssistListData {
  AssistListData({
    this.iIdHorario = 0,
    this.cfolioEmpleado = '',
    required this.dtfechaRegistro,
    this.ctipoRegistro = '',
    this.lIncidencia = false,
  });
  int iIdHorario;
  String cfolioEmpleado;
  DateTime dtfechaRegistro;
  String ctipoRegistro;
  bool lIncidencia;

  static List<AssistListData> assistList = <AssistListData>[
    AssistListData(
      cfolioEmpleado: '305298',
      dtfechaRegistro: DateTime.parse('2022-11-11 07:25:00'),
      ctipoRegistro: 'entrada',
      lIncidencia: false,
    ),
    AssistListData(
      cfolioEmpleado: '305298',
      dtfechaRegistro: DateTime.parse('2022-11-11 03:35:00'),
      ctipoRegistro: 'salida',
      lIncidencia: false,
    ),
    AssistListData(
      cfolioEmpleado: '305298',
      dtfechaRegistro: DateTime.parse('2022-11-11 07:46:00'),
      ctipoRegistro: 'entrada',
      lIncidencia: true,
    ),
    AssistListData(
      cfolioEmpleado: '305298',
      dtfechaRegistro: DateTime.parse('2022-11-11 02:29:00'),
      ctipoRegistro: 'salida',
      lIncidencia: true,
    ),
    AssistListData(
      cfolioEmpleado: '305298',
      dtfechaRegistro: DateTime.parse('2022-11-11 07:25:00'),
      ctipoRegistro: 'entrada',
      lIncidencia: false,
    ),
  ];

  factory AssistListData.fromJson(Map<String, dynamic> json, String cFolio) =>
      AssistListData(
          cfolioEmpleado: cFolio,
          dtfechaRegistro: DateTime.parse(json["fecha_registro"]),
          ctipoRegistro: (json["tipo_registro"] == "e") ? "Entrada" : "Salida",
          lIncidencia: json["lIncidencia"],
          iIdHorario: int.parse(json["id_horario"]));
}
