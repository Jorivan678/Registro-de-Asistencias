class Reporte {
  int id;
  int idAssist;
  String folio;
  DateTime fecha;
  String descripcion;
  String tipo;

  Reporte(
      {this.id = 0,
      this.idAssist = 0,
      this.folio = '',
      required this.fecha,
      this.descripcion = '',
      this.tipo = ''});

  static List<Reporte> reportList = <Reporte>[
    Reporte(
        id: 1,
        idAssist: 1,
        folio: 'YUVIVHZ31',
        fecha: DateTime.parse('2022-09-01'),
        descripcion: 'Ha fallado la entrada',
        tipo: 'Entrada'),
    Reporte(
        id: 2,
        idAssist: 2,
        folio: 'ISDNGV02O',
        fecha: DateTime.parse('2022-09-02'),
        descripcion: 'Ha fallado la salida.',
        tipo: 'Salida'),
    Reporte(
        id: 3,
        idAssist: 3,
        folio: 'MP519GST0',
        fecha: DateTime.parse('2022-09-03'),
        descripcion: 'Ha fallado la salida',
        tipo: 'Salida'),
    Reporte(
        id: 4,
        idAssist: 5,
        folio: 'UZ2Y078GS',
        fecha: DateTime.parse('2022-09-04'),
        descripcion: 'Ha fallado la entrada',
        tipo: 'Entrada')
  ];
}
