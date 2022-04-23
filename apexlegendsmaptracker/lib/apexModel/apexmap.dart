import 'dart:convert';

class ApexMap {
  int start;
  int end;
  String mapName;
  int remainingMins;
  String mapBG;
  ApexMap(
      {required this.start,
      required this.end,
      required this.mapName,
      required this.remainingMins,
      required this.mapBG});

  factory ApexMap.fromJson(Map<String, dynamic> json) {
    print(json['asset']);
    return ApexMap(
        start: json['start'],
        end: json['end'],
        mapName: json['map'],
        remainingMins: json['remainingMins'],
        mapBG: json['asset']);
  }
  // return AM;
}
