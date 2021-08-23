import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev/bloc/post/post_bloc.dart';
import 'package:flutter_dev/widgets/post_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ScrollController _scrollController;
  List _posts;
  PostBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Dev"),
        ),
      body: _body(),
      );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 100 && context.read<PostBloc>().state is! PostLoading) {
      context.read<PostBloc>()..add(LoadPosts());
    }
  }

  Widget _body(){
    return BlocBuilder<PostBloc, PostState>(
      builder: (BuildContext context, PostState state) {
        if (state is PostLoadSuccess) {
          _posts = state.posts;
        }

        return Stack(
          children: [
            _list(),
            _status(state)
          ].where((c) => c != null).toList(),
        );
      },
    );

  }

  Widget _status( PostState state){
    if(state is PostLoading){
      return Center(child: CircularProgressIndicator());
    }
    else if(state is PostLoadFailure){
      return Center(
        child: TextButton(
            onPressed:(){
              context.read<PostBloc>().add(LoadPosts());
            },

            child: Text("Retry", style: TextStyle(fontSize: 30),))
      );
    }
    else{
      return null;
    }
  }

  Widget _list() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _posts?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return PostTile(_posts[index]);
      },
    );
  }
}
