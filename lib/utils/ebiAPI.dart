import 'package:ebi_trucking/utils/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EBIapi {
  List<CurrentLine> parseTables(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<CurrentLine>((json) => CurrentLine.fromJson(json))
        .toList();
  }

  Future<List<CurrentLine>> fetchTables() async {
    final response =
        await http.get('https://ebi-api.herokuapp.com/trucktraffic');
    if (response.statusCode == 200) {
      return parseTables(response.body);
    } else {
      throw Exception('Unable to fetch tables from the REST API');
    }
  }
}
