import 'package:http/http.dart' as http;
import 'dart:convert';
import '../apexModel/apexmap.dart';
import 'dart:async';

Future<ApexMap> fetchApexMap() async {
  String apiKey = "c46d1e51e5dc7e9bc11bf5bdd8368ab8";
  final response = await http
      .get(Uri.parse('https://api.mozambiquehe.re/maprotation?auth=$apiKey'));

  if (response.statusCode == 200) {
    final Map apexMap = json.decode(response.body);
    return ApexMap.fromJson(apexMap["current"]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load map');
  }
}
