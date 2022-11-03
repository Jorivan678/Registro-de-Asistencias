class AssistListData {
  AssistListData({
    this.titleTxt = '',
    this.departime = '',
    this.checkintime = '',
    this.date = '',
  });

  String titleTxt;
  String departime;
  String checkintime;
  String date;

  static List<AssistListData> assistList = <AssistListData>[
    AssistListData(
      titleTxt: 'NKPR52J4LD',
      checkintime: '8:03',
      departime: '-:-',
      date: '22/09/2022',
    ),
    AssistListData(
      titleTxt: 'KDVML5WFGQ',
      checkintime: '8:00',
      departime: '15:05',
      date: '21/09/2022',
    ),
    AssistListData(
      titleTxt: '75ZRULNGM9',
      checkintime: '7:56',
      departime: '15:30',
      date: '20/09/2022',
    ),
    AssistListData(
      titleTxt: 'CY2NT6C2EJ',
      checkintime: '7:58',
      departime: '16:06',
      date: '19/09/2022',
    ),
    AssistListData(
      titleTxt: 'DKWQQQTS3C',
      checkintime: '8:19',
      departime: '14:36',
      date: '18/09/2022',
    ),
  ];
}
