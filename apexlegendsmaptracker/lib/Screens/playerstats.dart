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
    playerModel = Player(0, " ", "PC", 0, 0,0);
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
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                        image: AssetImage('assets/kc.jpg'), fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    obscureText: false,
                    controller: userNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter username',
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 1, 20)),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          showAlertDialog(context);
                          playerModel = await fetchUserStats(
                              userNameController.text, "PC");
                          print("i was pressed" + playerModel.name);
                          Navigator.pop(context);
                          setState(() {
                            playerModel = playerModel;
                          });
                        },
                        child: const Text('Search')),
                  ],
                ),
                playerCard(playerModel)
              ],
            )
          ],
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
    var cardImage =
        NetworkImage('https://source.unsplash.com/random/800x600?house');
    var supportingText =
        'Beautiful home to rent, recently refurbished with modern appliances...';
    return Expanded(
        child: Card(
            child: Column(
      children: [
        ListTile(
          title: Text(
            heading,
            style: TextStyle(fontSize: 22),
          ),
          subtitle: Text(subheading),
          trailing: Icon(
            Icons.check_box_rounded,
            color: determineGameStatus(playerModel.isInGame),
          ),
        ),
        // Container(
        //   height: 200.0,
        //   child: Ink.image(
        //     image: cardImage,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.centerLeft,
          child: Text(playerModel.kills.toString()),
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
    )));

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
