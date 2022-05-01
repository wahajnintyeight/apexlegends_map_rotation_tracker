import 'dart:convert';

import 'dart:ffi';

class Player {
  String name;
  int uid;
  String platform;
  int level;

  Player.fromJson(Map<String, dynamic> json)
      : name = json['global']['name'],
        uid = json['global']['uid'],
        platform = json['global']['platform'],
        level = json['global']['level'];
  // return AM;
}
