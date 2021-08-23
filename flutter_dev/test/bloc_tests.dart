import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dev/bloc/post/post_bloc.dart';
import 'package:flutter_dev/models/post.dart';
import 'package:flutter_dev/repositories/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepo extends Mock implements PostRepository {}

main() {
  group('PostBloc', () {
    PostRepository repo;
    PostBloc bloc;
    List<Post> posts;

    setUp(() {
      repo = MockRepo();
      bloc = PostBloc(repo);
      posts = List();
    });

    tearDown(() {
      bloc?.close();
    });

    group('passes', () {
      setUp(() {
        when(() => repo.getPosts()).thenAnswer((_) => Future.value(posts));
      });
      
      blocTest(
        'emits [] when nothing is added',
        build: () => PostBloc(repo),
        expect: () => [],
      );

      blocTest(
        'emits PostLoading, PostLoadSuccess when LoadPosts is added',
        build: () => PostBloc(repo),
        act: (bloc) => bloc.add(LoadPosts()),
        expect: () => [isA<PostLoading>(), isA<PostLoadSuccess>()],
      );
    });

    // when(() => repo.getPosts()).thenThrow(Exception("Test"));
    group('fails', () {
      setUp(() {
        when(() => repo.getPosts()).thenThrow(Exception("Test"));
      });

      blocTest(
        'emits PostLoadFailure when exception is thrown',
        build: () => PostBloc(repo),
        act: (bloc) => bloc.add(LoadPosts()),
        expect: () => [isA<PostLoading>(), isA<PostLoadFailure>()],
      );
    });
  });
}
