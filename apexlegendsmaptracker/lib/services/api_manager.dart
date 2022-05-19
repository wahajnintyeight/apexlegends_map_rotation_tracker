import 'package:http/http.dart' as http;
import 'dart:convert';
import '../apexModel/apexmap.dart';
import 'dart:async';

import '../apexModel/playerModel.dart';

Future<void> fetchApexMap(StreamController<ApexMap> _streamController) async {
  String apiKey = "c46d1e51e5dc7e9bc11bf5bdd8368ab8";
  final response = await http
      .get(Uri.parse('https://api.mozambiquehe.re/maprotation?auth=$apiKey'));

  if (response.statusCode == 200) {
    final apexMap = json.decode(response.body);
    ApexMap apexMapModel = new ApexMap.fromJson(apexMap);
    print(apexMapModel);
    _streamController.sink.add(apexMapModel);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load map');
  }
}

Future<Player> fetchUserStats(String playerName, String platForm) async {
  String apiKey = "c46d1e51e5dc7e9bc11bf5bdd8368ab8";
  final response = await http.get(Uri.parse(
      'https://api.mozambiquehe.re/bridge?auth=$apiKey&player=$playerName&platform=$platForm'));
  print('I receive' + playerName);
  if (response.statusCode == 200) {
    final playerData = json.decode(response.body);
    print(playerData['legends']['selected']['ImgAssets']['icon']);
    Player playerModel = Player.fromJson(playerData);
    // print(playerModel.isInGame);
    return playerModel;
  } else {
    throw Exception('Failed to load player data');
  }
}
