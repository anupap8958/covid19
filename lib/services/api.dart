import 'dart:convert';

import 'package:covid/models/api_result.dart';
import 'package:covid/models/covid_items.dart';
import 'package:http/http.dart' as http;

class Api {
  static const BASE_URL = 'https://covid19.ddc.moph.go.th/api/Cases/today-cases-all';

  Future<dynamic> fetch() async {
    var url = Uri.parse('$BASE_URL');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // แปลง text ที่มีรูปแบบเป็น JSON ไปเป็น Dart's data structure (List/Map)
      print('RESPONSE BODY: ${response.body}');

      return Covid.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw 'Server connection failed!';
    }
  }
}