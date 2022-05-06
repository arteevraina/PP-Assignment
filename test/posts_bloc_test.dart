import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_perfect/posts/data/post.dart';
import 'package:pet_perfect/posts/presentation/bloc/posts_bloc.dart';
import 'package:pet_perfect/posts/repositories/posts_repository.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late MockPostsRepository mockPostsRepository;

  /// [sut] stand for System Under Test.
  late PostsBloc sut;

  setUpAll(() {
    mockPostsRepository = MockPostsRepository();
    sut = PostsBloc(postsRepository: mockPostsRepository);
  });

  group('Posts Bloc Tests', () {
    final mockPosts = [
      Post(title: "Title1", body: "Body1"),
      Post(title: "Title2", body: "Body2"),
      Post(title: "Title3", body: "Body3"),
      Post(title: "Title4", body: "Body4"),
      Post(title: "Title5", body: "Body5"),
    ];

    blocTest<PostsBloc, PostsState>(
      'should emit [FetchingPosts], [PostsLoaded] when [FetchPostsEvent] is added',
      build: () {
        when(() => mockPostsRepository.getPosts())
            .thenAnswer((_) async => mockPosts);

        return sut;
      },
      act: (bloc) => bloc.add(FetchPostsEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [FetchingPosts(), PostsLoaded(posts: mockPosts)],
    );
  });
}
