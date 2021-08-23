
import 'package:flutter/material.dart';
import 'package:flutter_dev/models/post.dart';
import 'package:flutter_dev/providers/post_provider.dart';

class PostRepository{
  List<Post> _posts;
  String _after;

  PostRepository() {
    _posts = List<Post>();
  }

  Future<List<Post>> getPosts() async {
    try {
      Map<String, dynamic> map = await PostProvider.getPosts(after: _after);
      map = map["data"];
      _after = map["after"];
      List<dynamic> list = map["children"];

      list.forEach((element) {
        Map<String, dynamic> details = element["data"];
        _posts.add(new Post(details["title"]));
      });
      return _posts;
    }
    catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}