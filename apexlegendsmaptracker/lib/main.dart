import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'services/api_manager.dart';
import 'package:http/http.dart' as http;
import '../apexModel/apexmap.dart';
import 'dart:convert';
import 'dart:async';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late Future<ApexMap> futureMap;
  StreamController<ApexMap> _streamController = StreamController();
  // ignore: non_constant_identifier_names
  // late ApexMap MapModel;
  String image = " ";
  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 20), (timer) {
      fetchApexMap(_streamController);
    });
    // ApexMap Map = ApexMap(start: start, end: end, mapName: mapName, remainingMins: remainingMins, mapBG: mapBG);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<String> maps = [
      "assets/noimage.png",
      "assets/stormpoint.jpg",
      "assets/olympus.png",
      "assets/kc.jpg"
    ];

    return MaterialApp(
        title: "Apex Legends Map Tracker",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
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
                                  decoration: fetchMapImage(
                                       maps, snapshot.data!),
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
                                "Duration: " +
                                    snapshot.data!.duration.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.orange),
                              ),
                              Text(
                                "Next Map: " +
                                    snapshot.data!.nextMap.toString(),
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
        ));
  }

  // setValues(String img) {}
  BoxDecoration fetchMapImage(List<String> maps, ApexMap map) {
    // dynamic value = map.mapName;
  
    if (map.mapName == "Storm Point") {
      return BoxDecoration(
          image:
              DecorationImage(image: AssetImage(maps[1]), fit: BoxFit.cover));
    } else if (map.mapName == "Olympus") {
      return BoxDecoration(
          image:
              DecorationImage(image: AssetImage(maps[2]), fit: BoxFit.cover));
    } else if (map.mapName == "Kings Canyon") {
      return BoxDecoration(
          image:
              DecorationImage(image: AssetImage(maps[3]), fit: BoxFit.cover));
    } else {
      return BoxDecoration(
          image:
              DecorationImage(image: AssetImage(maps[0]), fit: BoxFit.cover));
    }
  }
}
