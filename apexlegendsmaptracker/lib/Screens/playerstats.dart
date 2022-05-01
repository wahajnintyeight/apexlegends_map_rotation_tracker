import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../services/api_manager.dart';
import '../apexModel/playerModel.dart';
import 'dart:async';

class PlayerStats extends StatefulWidget {
  const PlayerStats({Key? key}) : super(key: key);

  @override
  State<PlayerStats> createState() => _PlayerStatsState();
}

class _PlayerStatsState extends State<PlayerStats> {
  StreamController<Player> _streamController = StreamController();

  @override
  void initState() {
    super.initState();

    // Timer.periodic(const Duration(seconds: 0), (timer) {
    fetchUserStats(_streamController, "WRA1Th_5598", "PC");
    // });
    // ApexMap Map = ApexMap(start: start, end: end, mapName: mapName, remainingMins: remainingMins, mapBG: mapBG);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/kc.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Expanded(
                flex: 6,
                child: const TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter username',
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: StreamBuilder<Player>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      padding: const EdgeInsets.only(top: 160),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data);
                        // return Text(snapshot.data[index]["name"]);
                        return Card(
                          color: Colors.black,
                          elevation: 2,
                          child: Column(
                            children: <Widget>[
                              Text(snapshot.data!.name,
                                  style: const TextStyle(
                                      fontSize: 36, color: Colors.yellow)),
                              const SizedBox(
                                height: 15,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
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
            ),
          ),
        ],
      ),
    );
  }
}
