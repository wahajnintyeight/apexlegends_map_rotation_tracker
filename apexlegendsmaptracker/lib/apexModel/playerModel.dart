import 'dart:convert';

import 'dart:ffi';

class Player {
  String name;
  int uid;
  String platform;
  int level;
  int isInGame;
  int kills;
  String selectLegendImage;

  Player(this.level, this.name, this.platform, this.uid, this.isInGame,
      this.kills,this.selectLegendImage) {
    level = 0;
    name = " ";
    platform = "PC";
    uid = 0;
    isInGame = 0;
    kills = 0;
    selectLegendImage = "";
  }
  Player.fromJson(Map<String, dynamic> json)
      : name = json['global']['name'],
        uid = json['global']['uid'],
        platform = json['global']['platform'],
        level = json['global']['level'],
        isInGame = json['realtime']['isOnline'],
        kills = json['legends']['selected']['data'][0]['value'],
        selectLegendImage = json['legends']['selected']['ImgAssets']['icon'];
  // return AM;
}
