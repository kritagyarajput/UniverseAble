import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:universe_able/enterDetails.dart';

import 'constants.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({this.username, this.token});
  final String username;
  final String token;
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String name;
  String res;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.username;
    res = widget.token;
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
                      Text(
                        'Calculate Your Carbon Footprint Score',
                        style: kHeadingFont.copyWith(fontSize: 30),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) => EnterDetails(
                              token: res,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
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
                                  fontSize: 25, color: Colors.blue[900]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Image(
                          image: AssetImage('images/earth.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.lightGreenAccent[700],
                ),
                child: Center(
                  child: Text('Leaderboard',
                      style: kHeadingFont.copyWith(color: Colors.blue[900])),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: MediaQuery.of(context).size.height * 1.03,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.lightGreenAccent[700],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Center(
                                  child: Text(
                                'Rank',
                                style: kFieldsFont.copyWith(
                                    color: Colors.blue[900]),
                              )),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 35),
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 10),
                              child: Center(
                                  child: Text(
                                'Name',
                                style: kFieldsFont.copyWith(
                                    color: Colors.blue[900]),
                              )),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Center(
                                  child: Text(
                                'Score',
                                style: kFieldsFont.copyWith(
                                    color: Colors.blue[900]),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.88,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView.builder(
                            itemCount: 25,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Text(
                                  '${index + 1}',
                                  style: kFieldsFont.copyWith(
                                      color: Colors.blue[900]),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
