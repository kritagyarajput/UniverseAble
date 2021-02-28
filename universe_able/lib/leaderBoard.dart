import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universe_able/userScore.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

Future<List<UserScore>> _getAllData() async {
  http.Response response =
      await http.get("http://192.168.29.14:8080/get-all-scores/");
  var gotData = jsonDecode(response.body);
  List<UserScore> userScoreList = [];
  for (var usd in gotData) {
    UserScore userData = UserScore(usd['id'], usd['user_name'], usd['score']);
    userScoreList.add(userData);
  }
  return userScoreList;
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getAllData(),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                  ),
                  backgroundColor: Colors.blue[900],
                  body: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            color: Colors.lightGreenAccent[700],
                          ),
                          child: Center(
                            child: Text('Leaderboard',
                                style: kHeadingFont.copyWith(
                                    color: Colors.blue[900])),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: Color(0xFF1D1E33),
                                  ),
                                  child: ListTile(
                                    subtitle: Center(
                                      child: Text(
                                        "User Name: ${snapshot.data[index].username}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Center(
                                      child: Text(
                                        "${snapshot.data[index].score}",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : CircularProgressIndicator();
        });
  }
}
