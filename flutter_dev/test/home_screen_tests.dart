import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev/bloc/post/post_bloc.dart';
import 'package:flutter_dev/models/post.dart';
import 'package:flutter_dev/screens/home_screen.dart';
import 'package:flutter_dev/widgets/post_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostBloc extends MockBloc<PostEvent, PostState> implements PostBloc {}

class FakePostEvent extends Fake implements PostEvent {}
class FakePostState extends Fake implements PostState {}


main() {
  setUpAll(() {
    registerFallbackValue<PostEvent>(FakePostEvent());
    registerFallbackValue<PostState>(FakePostState());
  });

  group('HomeScreenTests', () {
    PostBloc bloc;
    List<Post> posts;

    setUp(() {
      bloc = MockPostBloc();
      posts = List();

      // Stub the state stream
      whenListen(
        bloc,
        Stream.fromIterable([PostLoadSuccess(posts)]),
        initialState: PostInitial(),
      );
    });

    tearDown(() {
      bloc?.close();
    });

    Widget myAppWithMockBloc(){
      return BlocProvider(
        create: (context ) => bloc,
        child: MaterialApp(
          title: 'Flutter Dev',
          home: HomeScreen(),
        ),
      );
    }

    testWidgets('Display posts', (WidgetTester tester) async {

      // Given
      await tester.pumpWidget(myAppWithMockBloc());

      // When
      String postTitle = "POST A";
      posts.add(Post(postTitle));
      await tester.pumpAndSettle();

      // Then
      expect(find.text(postTitle), findsOneWidget);
      expect(find.byType(PostTile), findsOneWidget);
    });

    testWidgets('Display Circular Progress Indicator when loading', (WidgetTester tester) async {
      // Given
      whenListen(
        bloc,
        Stream.fromIterable([PostLoading()]),
        initialState: PostInitial(),
      );

      await tester.pumpWidget(myAppWithMockBloc());

      // When
      await tester.pump();

      // Then
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Display Retry when in error', (WidgetTester tester) async {
      // Given
      whenListen(
        bloc,
        Stream.fromIterable([PostLoadFailure()]),
        initialState: PostInitial(),
      );

      await tester.pumpWidget(myAppWithMockBloc());

      // When
      await tester.pump();

      // Then
      expect(find.text("Retry"), findsOneWidget);
    });
  });
}
