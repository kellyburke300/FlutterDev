import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev/bloc/post/post_bloc.dart';
import 'package:flutter_dev/widgets/post_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Dev"),
        ),
      body: _list(),
      );
  }

  Widget _list() {
    return BlocBuilder<PostBloc, PostState>(
      builder: (BuildContext context, PostState state) {
        if (state is PostLoadSuccess) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (BuildContext context, int index) {
              return PostTile(state.posts[index]);
            },
            );
        }
        else if (state is PostLoading) {
          // TODO Loading animation
          return Container(
            child: Center(
              child: Text("Loading"),
              ),
            );
        }
        else {
          return Container(
            child: Center(
              child: Text("Error"),
              ),
            );
        }
      },
      );
  }
}
