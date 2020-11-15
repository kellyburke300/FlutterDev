
part of 'post_bloc.dart';


@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoadSuccess extends PostState {
  final List<Post> posts;

  PostLoadSuccess([this.posts = const []]);
}

class PostLoadFailure extends PostState {}
