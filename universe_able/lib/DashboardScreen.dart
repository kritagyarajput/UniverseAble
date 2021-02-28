import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universe_able/enterDetails.dart';
import 'package:universe_able/leaderBoard.dart';
import 'dart:convert';
import 'constants.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({this.username, this.res, this.id});
  final String username;
  final res;
  final int id;
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String name;
  String token;
  int id;
  var score;
  bool haveScore = false;
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.username;
    token = widget.res['token'];
    id = widget.id;
    getScore(id);
  }

  Future getScore(int id) async {
    http.Response response =
        await http.get("http://192.168.29.14:8080/get-score/$id/");
    if (response.body != null) {
      print(response.body);
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  bool dataDeleted = false;
  Future<void> delScore(int id) async {
    http.Response response =
        await http.delete("http://192.168.29.14:8080/del-score/$id/");
    if (response.body != null) {
      setState(() {
        dataDeleted = true;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi,',
                        style: kHeadingFont,
                      ),
                      Text(
                        '$name',
                        style: kHeadingFont,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      (haveScore == true)
                          ? Column(
                              children: [
                                Container(
                                  child: Center(
                                    child: Text(
                                      "Your Score is: ${score['score']}",
                                      style: kHeadingFont,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      haveScore = !haveScore;
                                    });
                                    delScore(id);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.red,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 10,
                                              color: Colors.black45)
                                        ]),
                                    child: Center(
                                      child: Text(
                                        'Delete Score',
                                        style: kHeadingFont.copyWith(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  'Calculate Your Carbon Footprint Score:',
                                  style: kHeadingFont.copyWith(fontSize: 30),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final result = await showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          EnterDetails(
                                        token: token,
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        score = result;
                                        haveScore = true;
                                      });
                                    } else {}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.lightGreenAccent[700],
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 10,
                                              color: Colors.black45)
                                        ]),
                                    child: Center(
                                      child: Text(
                                        'Calculate',
                                        style: kHeadingFont.copyWith(
                                            fontSize: 25,
                                            color: Colors.blue[900]),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Image(
                          image: AssetImage('images/earth.png'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LeaderBoard()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Colors.yellow,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 10,
                                    color: Colors.black45)
                              ]),
                          child: Center(
                            child: Text(
                              'Show LeaderBoard',
                              style: kHeadingFont.copyWith(
                                  fontSize: 25, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
