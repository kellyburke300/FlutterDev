import 'dart:async';
import 'package:flutter_dev/bloc/post/post_bloc.dart';
import 'package:flutter_dev/models/post.dart';
import 'package:flutter_dev/repositories/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements PostRepository {}

main() {
  // TODO Failing tests
  group('ChannelBloc', () {
    MockRepository repo;
    PostBloc bloc;
    List<Post> posts;

    setUp(() {
      repo = MockRepository();
      bloc = PostBloc(repo);
      posts = List();

      when(repo.getPosts()).thenAnswer(
            (_) => Future.value(posts),
            );
    });

    tearDown(() {
      bloc?.close();
    });


    group('Load', () {
      test('emits [PostLoading, PostLoadSuccess] when posts are loaded',
                   () {
                 // Given
                 final Post post = Post("Post 1");
                 posts.add(post);

                 // Then
                 expectLater(
                   bloc,
                   emitsInOrder([
                                  PostLoading(),
                                  PostLoadSuccess(posts),
                                ]),
                   );

                 // When
                 bloc.add(LoadPosts());
               });

      test(
          'emits [PostLoading, PostLoadFailure] when repository throws error',
              () {
            //Given
            when(repo.getPosts()).thenThrow('Testing Error Handling');

            // Then
            expectLater(
              bloc,
              emitsInOrder(<PostState>[
                             PostLoading(),
                             PostLoadFailure(),
                           ]),
              );

            // When
            bloc.add(LoadPosts());
          });
    });
  }, skip: true);
}
