import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostProvider{

  static Future<Map<String, dynamic>> getPosts() async {
    try {
      final response = await http.get(
        "https://www.reddit.com/r/FlutterDev.json",
        ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        return map;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }




}
