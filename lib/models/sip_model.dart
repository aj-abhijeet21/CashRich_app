class SipModel {
  late String? date;
  late String? equity;
  late String? description;
  late String? sensex;

  SipModel({
    required this.date,
    required this.equity,
    required this.description,
    required this.sensex,
  });

  factory SipModel.fromJson(Map<String, dynamic> json) {
    var date = json['date'].toString();
    // if (date != 'Today') {
    //   date = date.substring(date.length - 8, date.length);
    // }
    // date = date == 'Today' ? 'Today' : json['date'].toString().substring();
    final equity = json['equity'];
    final description = json['point'] ?? 'No Description Found';
    final sensex = json['sensex'] ?? '0';

    return SipModel(
      date: date,
      equity: equity,
      description: description,
      sensex: sensex,
    );
  }
}
