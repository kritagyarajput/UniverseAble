import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:universe_able/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnterDetails extends StatefulWidget {
  EnterDetails({this.token});
  final String token;
  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  String receivedToken;
  String dropdownvalue1 = "Large";
  String dropdownvalue2 = "Regular Meat";
  String dropdownvalue3 = "None";
  String dropdownvalue4 = "None";
  int members = 1;
  int house_size = 1;
  int food_choices;
  int water_consumption;
  int water_frequency = 1;
  int purchases = 0;
  int waste_production = 0;
  int recycle = 0;
  int transport_car;
  int transport_public;
  int transport_air;

  void _decrementQty() {
    if (members > 1) {
      setState(() {
        members--;
      });
    }
  }

  void _incrementQty() {
    setState(() {
      members++;
    });
  }

  void _decrementWf() {
    if (water_frequency > 1) {
      setState(() {
        water_frequency--;
      });
    }
  }

  void _incrementWf() {
    if (water_frequency < 10) {
      setState(() {
        water_frequency++;
      });
    }
  }

  void _decrementPy() {
    if (purchases > 0) {
      setState(() {
        purchases--;
      });
    }
  }

  void _incrementPy() {
    if (purchases < 10) {
      setState(() {
        purchases++;
      });
    }
  }

  void _decrementWastep() {
    if (waste_production > 0) {
      setState(() {
        waste_production--;
      });
    }
  }

  void _incrementWastep() {
    if (waste_production < 4) {
      setState(() {
        waste_production++;
      });
    }
  }

  void _decrementRec() {
    if (recycle > 0) {
      setState(() {
        recycle--;
      });
    }
  }

  void _incrementRec() {
    if (recycle < 6) {
      setState(() {
        recycle++;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receivedToken = widget.token;
  }

  String url = 'http://192.168.29.14:8080/post-details/';
  Future postRequest(Map map) async {
    FormData formData = FormData.fromMap(map);
    Response response;
    var dio = Dio();
    http.Response httpresponse = await http.post(url,
        body: map, headers: {"Authorization": "Token $receivedToken"});
    // response = await dio.post('http://192.168.29.14:8080/post-details/',
    //     data: formData,
    //     options: Options(headers: {
    //       "Content-Type": "multipart/form-data",
    //       "Authorization": "Token $receivedToken"
    //     }));

    if (httpresponse.statusCode != null) {
      return jsonDecode(httpresponse.body);
    } else {
      print(httpresponse.statusCode);
    }
  }

  // Future _postAllProvidedData(
  //   int members,
  //   int house_size,
  //   int food_choices,
  //   int water_consumption,
  //   int water_frequency,
  //   int purchases,
  //   int waste_production,
  //   int recycle,
  //   int transport_car,
  //   int transport_public,
  //   int transport_air,
  // ) async {
  //   print(receivedToken);
  //   http.Response response = await http.post(Uri.encodeFull(url),
  //       body: jsonEncode({
  //         "members": members,
  //         "house_size": house_size,
  //         "food_choices": food_choices,
  //         "water_consumption": water_consumption,
  //         "water_frequency": water_frequency,
  //         "purchases": purchases,
  //         "waste_production": waste_production,
  //         "recycle": recycle,
  //         "transport_car": transport_car,
  //         "transport_public": transport_public,
  //         "transport_air": transport_air,
  //       }),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "Authorization": "Token $receivedToken"
  //       });
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff00224A),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Center(
                child: Text(
                  'Enter Your Details Here:',
                  style:
                      kHeadingFont.copyWith(fontSize: 20, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'No. of Members: ',
                      style: kFieldsFont,
                    ),
                  ),
                  GestureDetector(
                    onTap: _decrementQty,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$members',
                    style: kFieldsFont,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: _incrementQty,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'House Size: ',
                      style: kFieldsFont,
                    ),
                  ),
                  DropdownButton(
                    style: kFieldsFont,
                    value: dropdownvalue1,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownvalue1 = newValue;
                      });
                      if (newValue == 'Large') {
                        setState(() {
                          house_size = 0;
                        });
                      } else if (newValue == 'Medium') {
                        setState(() {
                          house_size = 1;
                        });
                      } else if (newValue == 'Small') {
                        setState(() {
                          house_size = 2;
                        });
                      } else {
                        setState(() {
                          house_size = 3;
                        });
                      }
                    },
                    items: <String>['Large', 'Medium', 'Small', 'Appartment']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Food Choices: ',
                      style: kFieldsFont,
                    ),
                  ),
                  DropdownButton(
                    style: kFieldsFont,
                    value: dropdownvalue2,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownvalue2 = newValue;
                      });
                      if (newValue == 'Regular Meat') {
                        setState(() {
                          food_choices = 0;
                        });
                      } else if (newValue == 'Meat few times') {
                        setState(() {
                          food_choices = 1;
                        });
                      } else if (newValue == 'Vegetarian') {
                        setState(() {
                          food_choices = 2;
                        });
                      } else if (newValue == 'Vegan') {
                        setState(() {
                          food_choices = 3;
                        });
                      } else if (newValue == 'Pre-Packaged') {
                        setState(() {
                          house_size = 4;
                        });
                      }
                    },
                    items: <String>[
                      'Regular Meat',
                      'Meat few times',
                      'Vegetarian',
                      'Vegan',
                      'Pre-Packaged'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Water appliances: ',
                      style: kFieldsFont,
                    ),
                  ),
                  DropdownButton(
                    style: kFieldsFont,
                    value: dropdownvalue3,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownvalue3 = newValue;
                      });
                      if (newValue == 'Washing Machine') {
                        setState(() {
                          water_consumption = 0;
                        });
                      } else if (newValue == 'Dishwasher') {
                        setState(() {
                          water_consumption = 1;
                        });
                      } else if (newValue == 'Both') {
                        setState(() {
                          water_consumption = 2;
                        });
                      } else if (newValue == 'None') {
                        setState(() {
                          water_consumption = 3;
                        });
                      }
                    },
                    items: <String>[
                      'Washing Machine',
                      'Dishwasher',
                      'Both',
                      'None',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Water Frequency: ',
                      style: kFieldsFont,
                    ),
                  ),
                  GestureDetector(
                    onTap: _decrementWf,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$water_frequency',
                    style: kFieldsFont,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: _incrementWf,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Major Purchases/Year: ',
                      style: kFieldsFont,
                    ),
                  ),
                  GestureDetector(
                    onTap: _decrementPy,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$purchases',
                    style: kFieldsFont,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: _incrementPy,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Waste Production/Year: ',
                      style: kFieldsFont,
                    ),
                  ),
                  GestureDetector(
                    onTap: _decrementWastep,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$waste_production',
                    style: kFieldsFont,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: _incrementWastep,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Recycle/Year: ',
                      style: kFieldsFont,
                    ),
                  ),
                  GestureDetector(
                    onTap: _decrementRec,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$recycle',
                    style: kFieldsFont,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: _incrementRec,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Miles diven /year: ',
                style: kFieldsFont,
              ),
              SizedBox(
                height: 7,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    transport_car = int.parse(value);
                  });
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Average Miles/year',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blue[900]),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Public transport Miles /year: ',
                style: kFieldsFont,
              ),
              SizedBox(
                height: 7,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    transport_public = int.parse(value);
                  });
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Average Miles/year',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blue[900]),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Travel by air: ',
                      style: kFieldsFont,
                    ),
                  ),
                  DropdownButton(
                    style: kFieldsFont,
                    value: dropdownvalue4,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownvalue4 = newValue;
                      });
                      if (newValue == 'None') {
                        setState(() {
                          transport_air = 0;
                        });
                      } else if (newValue == 'State Travel') {
                        setState(() {
                          transport_air = 1;
                        });
                      } else if (newValue == 'Country Travel') {
                        setState(() {
                          transport_air = 2;
                        });
                      } else if (newValue == 'Continent Travel') {
                        setState(() {
                          transport_air = 3;
                        });
                      }
                    },
                    items: <String>[
                      'None',
                      'State Travel',
                      'Country Travel',
                      'Continent Travel',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  Map<String, String> map = {
                    'members': "$members",
                    'house_size': "$house_size",
                    'food_choices': "$food_choices",
                    'water_consumption': "$water_consumption",
                    'water_frequency': "$water_frequency",
                    'purchases': "$purchases",
                    'waste_production': "$waste_production",
                    'recycle': "$recycle",
                    'transport_car': "$transport_car",
                    'transport_public': "$transport_public",
                    'transport_air': "$transport_air"
                  };
                  print("members=$members");
                  print("house=$house_size");
                  print("food=$food_choices");
                  print("water =$water_consumption");
                  print("water fre=$water_frequency");
                  print("purechase s=$purchases");
                  print("waste=$waste_production");
                  print("recycle=$recycle");
                  print("transport=$transport_car");
                  print("transport pub=$transport_public");
                  print("Transport air=$transport_air");

                  try {
                    var res = await postRequest(map);

                    print(res);
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue[900]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: kHeadingFont.copyWith(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
