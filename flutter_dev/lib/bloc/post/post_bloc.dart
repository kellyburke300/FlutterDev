import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_dev/models/post.dart';
import 'package:flutter_dev/repositories/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repo;
  PostBloc(this.repo) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
      PostEvent event,
      ) async* {
    if(event is LoadPosts){
      yield* _load();
    }
  }

  Stream<PostState> _load() async* {
    try {
      yield PostLoading();
      final posts = await repo.getPosts();
      yield PostLoadSuccess(posts);
    } catch (_) {
      yield PostLoadFailure();
    }
  }
}
