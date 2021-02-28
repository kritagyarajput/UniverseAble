import 'package:flutter/material.dart';
import 'package:flutter_login/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:universe_able/constants.dart';
import 'package:universe_able/registrationUi.dart';
import 'dart:convert';
import 'DashboardScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  String username;

  String registrationUrl = 'http://192.168.29.14:8080/user/register/';
  String loginUrl = 'http://192.168.29.14:8080/user/login/';

  Future postRegistrationData(
      String rUsername, String rEmail, String rPassword) async {
    http.Response response = await http.post(registrationUrl, body: {
      'username': rUsername,
      'email': rEmail,
      'password': rPassword,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body).toString();
    } else {
      print(response.statusCode);
    }
  }

  Future postLoginData(String rUsername, String rPassword) async {
    http.Response response = await http.post(loginUrl, body: {
      'username': rUsername,
      'password': rPassword,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
  // Future<String> _recoverPassword(String name) {
  //   // print('Name: $name');
  //   // return Future.delayed(loginTime).then((_) {
  //   //   if (!users.containsKey(name)) {
  //   //     return 'Username not exists';
  //   //   }
  //   //   return null;
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/bg1.png'),
          fit: BoxFit.fill,
        )),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: HeroTextWidget(
                    child: Text(
                      'Universe Able',
                      style: kHeadingFont,
                    ),
                    tag: 'logo',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: mq.height / 2.5,
                  width: mq.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 18.0,
                          color: Colors.black45)
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Login',
                        style: kHeadingFont.copyWith(fontSize: 25),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Enter Username',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Enter Password',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var res = await postLoginData(username, password);
                          String token = res['token'];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen(
                                      username: username, token: token)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: Text(
                              'Login',
                              style: kHeadingFont.copyWith(fontSize: 20),
                            ),
                          ),
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
                                    builder: (context) => RegistrationUi()));
                          },
                          child: Text('Register'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextFormField(
//             onChanged: (value) {
//               setState(() {
//                 username = value;
//               });
//             },
//           ),
//           TextFormField(
//             onChanged: (value) {
//               setState(() {
//                 email = value;
//               });
//             },
//           ),
//           TextFormField(
//             onChanged: (value) {
//               setState(() {
//                 password = value;
//               });
//             },
//           ),
//           GestureDetector(
//             child: Text('Login'),
//             onTap: () async {
              
//             },
//           )
//         ],
//       ),
//     );