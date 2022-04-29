import 'dart:convert';

class ApexMap {
  int start;
  int end;
  String mapName;
  int remainingMins;
  String mapBG;
  int remainingSecs;
  String remainingTimer;
  int duration;
  String nextMap;
  // ApexMap(
  //     {required this.start,
  //     required this.end,
  //     required this.mapName,
  //     required this.remainingMins,
  //     required this.mapBG});

  // factory ApexMap.fromJson(Map<String, dynamic> json) {
  //   print(json['asset']);
  //   return ApexMap(
  //       start: json['start'],
  //       end: json['end'],
  //       mapName: json['map'],
  //       remainingMins: json['remainingMins'],
  //       mapBG: json['asset']);
  // }
  ApexMap.fromJson(Map<String, dynamic> json)
      : start = json['current']['start'],
        end = json['current']['end'],
        mapName = json['current']['map'],
        remainingMins = json['current']['remainingMins'],
        mapBG = json['current']['asset'],
        remainingSecs = json['current']['remainingSecs'],
        remainingTimer = json['current']['remainingTimer'],
        duration = json['current']['DurationInMinutes'],
        nextMap = json['next']['map'];
  // return AM;
}
