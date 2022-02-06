import 'dart:convert';

import 'package:cashrich_app/models/sip_model.dart';
import 'package:http/http.dart' as http;

Future<List<SipModel>> getData() async {
  var url = Uri.parse(
      'https://interview-d8bf8-default-rtdb.firebaseio.com/dsip.json');
  var response = await http.get(url);
  // print(response.statusCode);
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    // print(jsonData);
    List<SipModel> sipList = [];

    jsonData.forEach((element) => sipList.add(SipModel.fromJson(element)));
    return sipList;
  } else {
    throw Exception('Unable to fetch data');
  }
}
