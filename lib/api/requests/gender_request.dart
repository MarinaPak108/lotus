import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm_project/api/dto/gender_dto.dart';
import 'package:sqflite/sql.dart';

class GenderRequest {
  //get api request
  Future<Gender> getRequest(String name) async {
    final uri = Uri.parse("https://api.genderize.io?name=$name");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Gender.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load gender data related to name');
    }
  }

  //post api request
  Future<Gender> postRequest(
      String name, String gender, String probability, String count) async {
    Map<String, dynamic> request = {
      'name': name,
      'gender': gender,
      'probability': probability,
      'count': count
    };
    final uri = Uri.parse("https://api.genderize.io?name=rachel");
    final response = await http.post(uri, body: request);

    if (response.statusCode == 201) {
      return Gender.fromJson(json.decode(response.body));
    } else {
      throw escapeName("Failed to post");
    }
  }

  //update api request
  Future<Gender> updateRequest(
      String name, String gender, String probability, String count) async {
    Map<String, dynamic> request = {
      'name': name,
      'gender': gender,
      'probability': probability,
      'count': count
    };

    final uri = Uri.parse("https://api.genderize.io?name=rachel");
    final response = await http.put(uri, body: request);

    if (response.statusCode == 200) {
      return Gender.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to update");
    }
  }
}
