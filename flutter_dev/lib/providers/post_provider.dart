import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostProvider{

  static Future<Map<String, dynamic>> getPosts({@required String after}) async {
    try {
      int _limit = 25;
      final response = await http.get(
        Uri.parse("https://www.reddit.com/r/FlutterDev.json?limit=$_limit&after=$after"),
        ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        return map;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }




}
