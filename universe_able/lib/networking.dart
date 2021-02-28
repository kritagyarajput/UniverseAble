import 'package:http/http.dart' as http;
import 'dart:convert';
class Networking {
  String registerUrl;
  String loginUrl;
   Future postRegistration() async {
    http.Response response = await http.get(
        'https://corona.lmao.ninja/v2/countries/india?yesterday=true&strict=true&query');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
