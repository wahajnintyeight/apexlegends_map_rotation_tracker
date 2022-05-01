import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../services/api_manager.dart';
import '../apexModel/apexmap.dart';
import 'dart:async';

import 'menu.dart';

class LiveMap extends StatefulWidget {
  const LiveMap({Key? key}) : super(key: key);

  @override
  State<LiveMap> createState() => _LiveMapState();
}

class _LiveMapState extends State<LiveMap> {
  StreamController<ApexMap> _streamController = StreamController();
  String image = " ";
  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 0), (timer) {
      fetchApexMap(_streamController);
    });
    // ApexMap Map = ApexMap(start: start, end: end, mapName: mapName, remainingMins: remainingMins, mapBG: mapBG);
  }

  List<String> maps = [
    "assets/noimage.png",
    "assets/stormpoint.jpg",
    "assets/olympus.png",
    "assets/kc.jpg"
  ];
  Widget build(BuildContext context) {
    return
        Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(
          builder: (context) => WelcomeScreen())))),
      body: Container(
        color: Colors.black,
        child: Center(
            child: StreamBuilder<ApexMap>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data);
                    // return Text(snapshot.data[index]["name"]);
                    return Card(
                      color: Colors.black,
                      elevation: 2,
                      child: Column(
                        children: <Widget>[
                          Text(snapshot.data!.mapName,
                              style: const TextStyle(
                                  fontSize: 36, color: Colors.yellow)),
                          Hero(
                            tag: snapshot.data!.mapName,
                            child: Container(
                              width: 600,
                              height: 400,
                              decoration: fetchMapImage(maps, snapshot.data!),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "Remaining time: " +
                                  snapshot.data!.remainingTimer.toString(),
                              style: const TextStyle(
                                  fontSize: 26, color: Colors.green),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Duration: " + snapshot.data!.duration.toString(),
                            style:
                                TextStyle(fontSize: 20, color: Colors.orange),
                          ),
                          Text(
                            "Next Map: " + snapshot.data!.nextMap.toString(),
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    );
                  });
              // return Text(snapshot.data!.mapName);
            } else if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.cyan),
              );
            }
            return const CircularProgressIndicator();
          },
        )),
      ),
    );
  }
}

BoxDecoration fetchMapImage(List<String> maps, ApexMap map) {
  // dynamic value = map.mapName;

  if (map.mapName == "Storm Point") {
    return BoxDecoration(
        image: DecorationImage(image: AssetImage(maps[1]), fit: BoxFit.cover));
  } else if (map.mapName == "Olympus") {
    return BoxDecoration(
        image: DecorationImage(image: AssetImage(maps[2]), fit: BoxFit.cover));
  } else if (map.mapName == "Kings Canyon") {
    return BoxDecoration(
        image: DecorationImage(image: AssetImage(maps[3]), fit: BoxFit.cover));
  } else {
    return BoxDecoration(
        image: DecorationImage(image: AssetImage(maps[0]), fit: BoxFit.cover));
  }
}
