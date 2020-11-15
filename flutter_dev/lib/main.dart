import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev/Screens/home_screen.dart';
import 'package:flutter_dev/repositories/post_repository.dart';

import 'bloc/post/post_bloc.dart';
import 'bloc/post/post_oberver.dart';

void main() {
  runApp(MyApp());
}


/// Created StatefulWidget for creating and closing bloc
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PostBloc bloc = PostBloc(PostRepository());

  @override
  Widget build(BuildContext context) {
    Bloc.observer = PostBlocObserver();
    return BlocProvider(
      create: (context ) => bloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Dev',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        home: HomeScreen(),
        ),
      );
  }

  @override
  void initState(){
    bloc.add(LoadPosts());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
