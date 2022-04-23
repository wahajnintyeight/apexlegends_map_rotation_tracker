import 'package:flutter/material.dart';
import 'services/api_manager.dart';
import 'package:http/http.dart' as http;
import '../apexModel/apexmap.dart';
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<ApexMap> futureMap;
  // String image = " ";
  @override
  void initState() {
    super.initState();
    futureMap = fetchApexMap();
    // ApexMap Map = ApexMap(start: start, end: end, mapName: mapName, remainingMins: remainingMins, mapBG: mapBG);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    
  // // if image == "" {

  //  String bgImage = 'https://epingi.com/wp-content/uploads/2020/03/Apex-Legends-PC-Version-Full-Game-Free-Download.jpg';
  // // } 

//    https://epingi.com/wp-content/uploads/2020/03/Apex-Legends-PC-Version-Full-Game-Free-Download.jpg
    return MaterialApp(
        title: 'Flutter Demso',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text('Apex Legends Map Rotation')),
          body: Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: NetworkImage("https://epingi.com/wp-content/uploads/2020/03/Apex-Legends-PC-Version-Full-Game-Free-Download.jpg"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Center(
                child: FutureBuilder<ApexMap>(
              future: futureMap,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // setState(() {
                  //   image =  snapshot.data!.mapBG;
                  // });
                  // print(image);
                  return Text(snapshot.data!.mapName);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            )),
          ),
        ));
  }
}
