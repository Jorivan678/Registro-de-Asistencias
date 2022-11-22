class AssistListData {
  AssistListData(
      {this.id = 0,
      this.titleTxt = '',
      this.departime = '',
      this.checkintime = '',
      required this.date});

  int id;
  String titleTxt;
  String departime;
  String checkintime;
  DateTime date;

  static List<AssistListData> assistList = <AssistListData>[
    AssistListData(
      id: 1,
      titleTxt: 'NKPR52J4LD',
      checkintime: '8:03',
      departime: '-:-',
      date: DateTime.parse('2022-09-22'),
    ),
    AssistListData(
      id: 2,
      titleTxt: 'KDVML5WFGQ',
      checkintime: '8:00',
      departime: '15:05',
      date: DateTime.parse('2022-09-21'),
    ),
    AssistListData(
      id: 3,
      titleTxt: '75ZRULNGM9',
      checkintime: '7:56',
      departime: '15:30',
      date: DateTime.parse('2022-09-20'),
    ),
    AssistListData(
      id: 4,
      titleTxt: 'CY2NT6C2EJ',
      checkintime: '7:58',
      departime: '16:06',
      date: DateTime.parse('2022-09-19'),
    ),
    AssistListData(
      id: 5,
      titleTxt: 'DKWQQQTS3C',
      checkintime: '8:19',
      departime: '14:36',
      date: DateTime.parse('2022-09-18'),
    ),
  ];
}
