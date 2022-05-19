import 'package:apexlegendsmaptracker/Screens/menu.dart';
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
  // StreamController<Player> _streamController = StreamController();
  TextEditingController userNameController = TextEditingController();
  late Player playerModel;
  @override
  void initState() {
    playerModel = Player(0, " ", "PC", 0, 0, 0, " ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen())))),
        body: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: TextField(
                  obscureText: false,
                  controller: userNameController,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    focusColor: Colors.yellow,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(60.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(60.0)),
                      fillColor: Colors.white,
                      labelText: 'Enter username',
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 20, 1, 20)),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        showAlertDialog(context);
                        playerModel =
                            await fetchUserStats(userNameController.text, "PC");
                        Navigator.pop(context);
                        setState(() {
                          playerModel = playerModel;
                        });
                      },
                      child: const Text('Search')),
                ],
              ),
              Row(
                children: <Widget>[
                  playerCard(playerModel),
                ],
              )
            ],
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget playerCard(Player playerModel) {
    var heading = playerModel.name;
    var subheading = playerModel.level.toString();
    var cardImage = NetworkImage(playerModel.selectLegendImage);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var supportingText =
        'Beautiful home to rent, recently refurbished with modern appliances...';
    return Expanded(
        child: Center(
      child: Card(
          color: Color.fromARGB(255, 172, 194, 44),
          child: Column(
            children: <Widget>[
              Text(playerModel.name,
                  style: TextStyle(fontSize: 26, color: Colors.white)),
              ListTile(
                title: Text(
                  "Level: " + playerModel.level.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(
                  Icons.circle_rounded,
                  color: determineGameStatus(playerModel.isInGame),
                ),
              ),
              Container(
                width: screenWidth * 0.30,
                height: screenHeight * 0.30,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(10),
                child: Ink.image(
                  image: cardImage,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  playerModel.kills.toString() + " kills",
                  style: TextStyle(color: Colors.redAccent, fontSize: 20),
                ),
              ),
              // ButtonBar(
              //   children: [
              //     TextButton(
              //       child: const Text('CONTACT AGENT'),
              //       onPressed: () {/* ... */},
              //     ),
              //     TextButton(
              //       child: const Text('LEARN MORE'),
              //       onPressed: () {/* ... */},
              //     )
              //   ],
              // )
            ],
          )),
    ));

    // return Card(
    //     child: Column(
    //   children: [
    //     ListTile(
    //       title: Text(heading),
    //       subtitle: Text(subheading),
    //       trailing: Icon(Icons.favorite_outline),
    //     ),
    //     Container(
    //       height: 200.0,
    //       child: Ink.image(
    //         image: cardImage,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     Container(
    //       padding: EdgeInsets.all(16.0),
    //       alignment: Alignment.centerLeft,
    //       child: Text(supportingText),
    //     ),
    //     ButtonBar(
    //       children: [
    //         TextButton(
    //           child: const Text('CONTACT AGENT'),
    //           onPressed: () {/* ... */},
    //         ),
    //         TextButton(
    //           child: const Text('LEARN MORE'),
    //           onPressed: () {/* ... */},
    //         )
    //       ],
    //     )
    //   ],
    // ));
  }

  Color determineGameStatus(int status) {
    if (status == 0) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}
