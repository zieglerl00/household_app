import 'dart:convert';
import 'package:http/http.dart' as http;

// const String apiUrl = "http://0.0.0.0:8000/";
const String apiUrl = "https://zmessenger.herokuapp.com/api/";

class BaseClient {

  var client = http.Client();

  Future<dynamic> get(String api) async {
    var url = Uri.parse(apiUrl + api);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Exception");
    }
  }

  Future<dynamic> post(String api, String item, String quantity) async {
    var response = await http.post(
      Uri.parse(apiUrl + api),
      body: {
        "name": item,
        "quantity": quantity,
      }
    );
    print(response.body);
  }

  Future<dynamic> put(String api) async {

  }

  Future<dynamic> delete(String api, String id) async {
    var response = await http.delete(
        Uri.parse(apiUrl + api + id),
    );
    print(response);
  }
}