import 'package:apexlegendsmaptracker/Screens/livemap.dart';
import 'package:apexlegendsmaptracker/Screens/playerstats.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/73/c7/88/73c788be8e67e652c6c61d99e5d3b153.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, left: 25),
                  child: Column(
                    children: [
                      Text(
                        'Apex Legends Tracker',
                        style: TextStyle(
                            fontSize: 35,
                            wordSpacing: 5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 48, 168, 198),
                              Color.fromARGB(255, 236, 37, 193)
                            ],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft,
                          ),
                        ),
                        child: FlatButton(
                          child: Text(
                            'Track your profile',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'arial'),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayerStats())),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        child: Container(
                          margin: EdgeInsets.all(20),
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 42, 168, 198),
                                Color.fromARGB(255, 236, 87, 193)
                              ],
                              begin: FractionalOffset.topRight,
                              end: FractionalOffset.bottomLeft,
                            ),
                          ),
                          child: FlatButton(
                            child: Text(
                              'Live Map',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'arial'),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LiveMap())),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
