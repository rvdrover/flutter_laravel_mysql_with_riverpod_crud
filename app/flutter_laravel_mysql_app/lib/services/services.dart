import 'dart:convert';

import 'package:flutter_laravel_mysql_app/models/emp_model.dart';
import 'package:http/http.dart' as http;

class Services {
  static String baseUrl = 'http://192.168.8.165:8080/api/emp/';

  static Future<List<EmpModel>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (200 == response.statusCode) {
        List<EmpModel> list = parseResponse(response.body);
        return list;
      } else {
        return <EmpModel>[];
      }
    } catch (e) {
      return <EmpModel>[];
    }
  }

  static List<EmpModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<EmpModel>((json) => EmpModel.fromJson(json)).toList();
  }

  static Future<String> addEmp(String firstName, String lastName) async {
    try {
      var map = <String, dynamic>{};
      map['firstname'] = firstName;
      map['lastname'] = lastName;
      final response = await http.post(Uri.parse(baseUrl), body: map);
      print('Add Emp Response: ${response.body}');
      if (200 == response.statusCode) {
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateEmp(
      int id, String firstname, String lastname) async {
    try {
      var map = <String, dynamic>{};
      map['firstname'] = firstname;
      map['lastname'] = lastname;
      final response = await http.put(Uri.parse("$baseUrl$id"), body: map);
      print('Update Emp Response: ${response.body}');
      if (200 == response.statusCode) {
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> deleteEmp(int id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl$id"));
      print('Delete Emp Response: ${response.body}');
      if (200 == response.statusCode) {
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
