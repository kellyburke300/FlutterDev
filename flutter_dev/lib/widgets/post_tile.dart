import 'package:flutter/material.dart';
import 'package:flutter_dev/models/post.dart';
class PostTile extends StatelessWidget {
  final Post post;

  PostTile(this.post);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title),
        ),
      );
  }
}
