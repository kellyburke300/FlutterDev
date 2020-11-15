
import 'package:flutter_dev/models/post.dart';

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

  Future<List<Post>> getPosts(){
    return Future.value(_posts);
  }
}