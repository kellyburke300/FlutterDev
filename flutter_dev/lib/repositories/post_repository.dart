
import 'package:flutter/material.dart';
import 'package:flutter_dev/models/post.dart';
import 'package:flutter_dev/providers/post_provider.dart';

class PostRepository{
  List<Post> _posts;

  PostRepository() {
    _posts = List<Post>();
    _posts.add(new Post("Post A"));
    _posts.add(new Post("Post B"));
    _posts.add(new Post("Post C"));
    _posts.add(new Post("Post D"));
    _posts.add(new Post("Post E"));
    _posts.add(new Post("Post F"));
  }

  Future<List<Post>> getPosts() async {
    try {
      _posts.clear();
      Map<String, dynamic> map = await PostProvider.getPosts();
      map = map["data"];
      List<dynamic> list = map["children"];

      list.forEach((element) {
        Map<String, dynamic> details = element["data"];
        _posts.add(new Post(details["title"]));
      });
      return _posts;
    }
    catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}