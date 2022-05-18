import 'dart:convert';

import 'dart:ffi';

class Player {
  String name;
  int uid;
  String platform;
  int level;
  int isInGame;
  int kills;

  Player(this.level, this.name, this.platform, this.uid, this.isInGame,
      this.kills) {
    level = 0;
    name = " ";
    platform = "PC";
    uid = 0;
    isInGame = 0;
    kills = 0;
  }
  Player.fromJson(Map<String, dynamic> json)
      : name = json['global']['name'],
        uid = json['global']['uid'],
        platform = json['global']['platform'],
        level = json['global']['level'],
        isInGame = json['realtime']['isOnline'],
        kills = json['legends']['selected']['data']['value'];
  // return AM;
}
